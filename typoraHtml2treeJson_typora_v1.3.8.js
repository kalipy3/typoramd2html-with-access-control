/*
 * 功能：typoraHtml2treeJson demo
 *
 * Copyright (C) 2022 2022-08 kalipy <kalipy@debian>
 *
 * Distributed under terms of the MIT license.
 */

const fs = require("fs")

fs.readFile("./NB-Iot-4.html","utf8",function(err,dataStr){
//fs.readFile("./皇帝内经.html","utf8",function(err,dataStr){
//fs.readFile("./readme2_linux3.8.html","utf8",function(err,dataStr){
    
    //正则的可读性比较差，注释也不太好写，请直接根据console.log("xx")打印的结果来分析每个正则实现的功能

    //let reg = /<div id='write'  class=''>(.*?)<\/div>\n<\/body>/igs
    //匹配html有效正文部分
    let reg = /<div id='write'  class=' first-line-indent'>(.*?)<\/div>\n<\/body>/igs
    let ret = reg.exec(dataStr)

    let chapters = []
    //匹配每个章节的完整信息
    //let reg1 = /<h([0-9](.*?) id=(.*?))>(.*?)<h([0-9] id=(.*?))>/igs//文章章节
    let reg1 = /<h(.*?) id=(.*?)>(.*?)<h(.*?) id=(.*?)>/igs//文章章节
    let reg3 = /<h(.*?) id=(.*?)>(.*?)<\/div>\n/igs//由于最后一个章节不符合reg1的格式，所以单独处理，因为一片文章的结束就是用的</div>，因为用</div>去匹配最后一个章节
    let ret2;
    let preIdx;
    //console.log(ret[0])
    
    //匹配每个章节的内部信息，如章节标题，章节层级，章节内容等
    while ((ret2 = reg1.exec(ret[0]))) {
    //console.log(ret2[0])
        preIdx = reg1.lastIndex
        last = ret2[0].lastIndexOf("<h")
        len = ret2[0].length - last
        reg1.lastIndex -= len//如<h3>...<h3 id="xx">匹配后，lastIndex指向最后一个`>`号，而第二个<h3>是下一个章节的起始要匹配的位置，所以lastIndex-=len就刚好是紧接着的下一个章节的起始位置
        //console.log("title:h" + ret2[1] + "  html片段：" + ret2[0].substring(0, last))
        //console.log("\r\n")
        chapters.push({level: ret2[1], html: ret2[0].substring(0, ret2[0].length - len)})
    }

    reg3.lastIndex = preIdx - len;
    let ret3 = reg3.exec(ret[0])
    //console.log("title:h" + ret3[1] + "  html片段：" + ret3[0].substring(0, ret3[0].length - 7))
    chapters.push({level: ret3[1], html: ret3[0].substring(0, ret3[0].length - 7)})

    //提取章节层级(level)，章节标题(title)，章节内容(html)，保存为result
    //let reg2 = /class="md-header-anchor"><\/a><span>(.*?)<\/span>/is
    let reg2 = /h(.*?) id=(.*?)><span>(.*?)<\/span>/is
    let ret4
    let result = []
    for (let i = 0; i < chapters.length; i++) {
        ret4 = reg2.exec(chapters[i].html)
        result.push({level: chapters[i].level, title: ret4[3], html: chapters[i].html})
    }

    adapter(result)

})

//adapter函数的功能：把eg1变成eg2的样子(1.给章节编上标号 2.先找到并设置每个章节的id和pid 3.根据pid把章节信息树状化，供前端组件和后端方便使用)
//eg1.
//{
//  level: '1',
//  title: 'aaa',
//  html: '<h1><a name="aaa" class="md-header-anchor"></a><span>aaa</span></h1>'
//},
//{
//  level: '2',
//  title: 'bbb',
//  html: '<h2><a name="bbb" class="md-header-anchor"></a><span>bbb</span></h2>'
//},

//eg2.
//{
//    id: 1,
//    pid: -1,//-1表示没有父节点
//    level: 1,
//    title: 'aaa',
//    permission: 'visitor',//这里权限字段是在java后端根据权限规则在service层进行添加
//    content: '<li>test</li>',//之后在java后端service层改为contentId，与article_chapter表进行关联
//    children: [{
//      id: 2,
//      pid: 1,
//      level: 2,
//      title: 'bbb',
//      permission: 'admin',
//      content: '<li>test</li>',
//      children: [{
//          ...
//          ...等等
//      }]
//    }]
//}

//#########################################################以下出现中文注释的部分都可以提取封装为一个个单独的函数，这里为了快速先写出代码看到效果，未来优化时请把注释部分封装为函数###############################################
function adapter(data) {
    //console.log(data)
    if (data.length <= 0) return

    let data2 = addNo(data)
    //console.log(data2)

    let arr = []
    //添加id
    for (let i = 0; i < data2.length; i++) {
        let obj = {
            id: i + 1,
            no: data2[i].no,
            level: data2[i].level,
            label: data2[i].title,
            content: data2[i].html
        }
        arr.push(obj)
    }

    let arr2 = []
    let pid = -1
    var stack = []
    //单调栈：找到每个节点左边第一个比其小的节点(即找到每个节点的父节点，即每个章节的父章节)，并设置每个节点的pid
    //很简单的一个算法，不懂的话请直接百度`单调栈`
    for (let i = 0; i < arr.length; i++) {
        while (stack.length != 0 && arr[i].level <= arr[stack[stack.length-1]].level) {
            pid = arr[stack[stack.length-1]].id
            stack.pop()
        }
        if (stack.length == 0) {
            pid = -1
        } else {
            pid = arr[stack[stack.length-1]].id
        }
        stack.push(i)

        let obj = {
            id: arr[i].id,
            pid: pid,
            no: arr[i].no,
            level: arr[i].level,
            label: arr[i].label,
            content: arr[i].content,
            children: []
        }
        arr2.push(obj)
    }

    //调试用 现在已经给每个文章章节设置好了其pid
    //for (let i = 0; i < arr2.length; i++) {
    //    console.log(arr2[i])
    //}

    //平坦结构树化，调整为eg2的树状形式
    //很简单的一个算法，不懂的话请直接百度`数组树化`
    let map = new Map()
    let arr3 = []
    for (let i = 0; i < arr2.length; i++) {
        map.set(arr2[i].id, arr2[i])
    }
    for (let i = 0; i < arr2.length; i++) {
        let obj = arr2[i]
        let obj2 = map.get(obj.pid)
        if (obj2 == null || obj2 == undefined || obj.pid == -1) {
            arr3.push(obj)
        } else {
            map.get(obj.pid).children.push(obj)
        }
    }

    console.dir(arr3, {depth:null})

}

//给章节名添加1.x.y这样的标号 这里使用n^2时间复杂度的普通思路，建议优化时替换为n时间复杂度的`单调栈`实现
function addNo(data) {
    let res = []

    //章节编号
    let no = [0, 0, 0, 0, 0, 0, 0]//h1-h6 arr[0]不使用
    let strNo = ""
    for (let i = 0; i < data.length; i++) {
        strNo = ""
        no[data[i].level-'0']++
        if (i > 0 && data[i].level < data[i-1].level) {
            for (let j = data[i].level-'0' + 1; j < no.length; j++) {
                no[j] = 0
            }
        }

        for (let k = 1; k < no.length; k++) {
            strNo += (no[k] + ".")
        }
        //去掉多余的...0.0.0，比如strNo = 1.1.2.0.0.0，变成1.1.2，你也可以在上面的for循环提前处理".0"进行break
        strNo = strNo.substring(0, strNo.indexOf(".0"))

        let obj = {
            no: strNo,
            level: data[i].level,
            title: data[i].title,
            html: data[i].html
        }
        res.push(obj)
    }

    return res
}
