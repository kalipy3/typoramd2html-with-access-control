<template>
    <div>
        <div class="file">
            文章上传测试(请上传typora md转换后的html文章)
            <input type="file"  @change="uploadFile($event)" >
        </div>
        <el-container v-if="isShow">
            <el-header height="33px">{{curArticleTitle}}</el-header>
            <el-container>
                <el-aside width="auto">
                    <!--<ul>
                        <li v-on:click="aClick(item)" v-for="item in data">
                        <el-link>{{item.label}}</el-link>
                        </li>
                        </ul>-->

                        <!--<el-tree :data="data" :highlight-current=true :props="defaultProps" @node-click="handleNodeClick"></el-tree>-->
                        <el-tree :data="data" :highlight-current=true :props="defaultProps" @node-click="handleNodeClick">
                            <span slot-scope="{node, data}">
                                <span v-bind:style="{'color': data.id == 1 || data.id==2 || data.id==3 ? '': ''}">{{data.no}} {{data.label}}</span>
                                <span v-if="curChapter2PermissionMap.get(data.id) == 4" style="color: green;">(可试看)</span>
                                <span v-else-if="curChapter2PermissionMap.get(data.id) <= userRoleId" style="color: red;">(vip)</span>
                            </span>
                        </el-tree>
                </el-aside>
                <el-main>
                    <div v-html="htmlView">
                    </div>
                </el-main>

                <el-aside width="auto">
                    <ul>
                        <li v-on:click="toPaper(item)" v-for="item in paper">
                        <el-link>{{item.title.replace('.html', '.md')}}</el-link>
                        </li>
                        </ul>

                </el-aside>

            </el-container>
        </el-container>

        <!--
        <div v-html="htmlMdTemplate">
        </div>

        <el-link v-on:click="aClick(item)" v-for="item in dataList" type="success">{{item.label}}</el-link>
        <div v-html="menu">
        </div>
        <div class="hello">
            <el-button v-on:click="printMenu(data)">btn</el-button>
            <el-button v-on:click="article2">article2</el-button>
            <el-button v-on:click="getPaper">getPaper</el-button>
            <el-button v-on:click="getArticleMenu(1)">getArticleMenu</el-button>
            <el-button v-on:click="getChaptersPermissions(1)">getChaptersPermissions</el-button>
            <el-button v-on:click="getChapterContent(1, 1)">getChapterContent</el-button>
        </div>
        -->
    </div>
</template>

<script>

import { listMenu } from "../../../api/system/menu";

import request from '../../../utils/request'

export default {
    data() {
        return {
            userRoleId: 999999,//反正一个超大的数即可
            paper: [],
            curArticleId: 1,
            curArticleTitle: "",
            curChapter2PermissionMap: new Map(),
            articleName: "",
            htmlView:'',
            menu:'',
            str: '',
            dataList: [],
            htmlFile: '',
            htmlMdTemplate: '',
            adapterData: [],
            isShow: false,
            data: [{
                label: '一级 1',
                url: '/a',
                permission: 'admin',
                content: '<li>test</li>',//之后改为id
                children: [{
                    label: '二级 1-1',
                    url: '/b',
                    children: [{
                        url: '/c',
                        label: '三级 1-1-1'
                    }]
                }]
            }, {
                label: '一级 2',
                url: '/d',
                children: [{
                    url: '/e',
                    label: '二级 2-1',
                    children: [{
                        url: '/f',
                        label: '三级 2-1-1'
                    }]
                }, {
                    label: '二级 2-2',
                    url: '/g',
                    children: [{
                        url: '/h',
                        label: '三级 2-2-1'
                    }]
                }]
            }, {
                url: '/i',
                label: '一级 3',
                children: [{
                    url: '/j',
                    label: '二级 3-1',
                    children: [{
                        url: '/k',
                        label: '三级 3-1-1'
                    }]
                }, {
                    url: '/l',
                    label: '二级 3-2',
                    children: [{
                        url: '/m',
                        label: '三级 3-2-1'
                    }]
                }]
            }],
            defaultProps: {
                children: 'children',
                label: 'label'
            }
        };
    },
    async mounted() {
        await this.getUserRoleId()
        await this.updateCurPage()
    },
    methods: {
        async getUserRoleId() {
            let that = this
            request({
              url: '/user/',
              method: 'get'
            }).then(response => {
                console.log("getUserRoleId() resp:"+ response)
                that.userRoleId = response
            });
        },
        async updateCurPage() {
            //显示第一篇文章
            let res = await this.getPaper()
            if (res == undefined || res.length == 0) {
                this.data = []
                this.paper = []
                return;
            }
            this.isShow = true
            this.paper = res
            await this.getChaptersPermissions(this.paper[0].articleId)
            await this.getArticleMenu(this.paper[0].articleId)
            await this.getChapterContent(this.paper[0].articleId, 1)
            this.curArticleTitle = this.paper[0].title.substring(0, this.paper[0].title.length - 5)
        },
        async handleNodeClick(data) {
            console.log(data)
            //请求服务端articleId + text_id + permission(前端没有直接不请求后端) --> mysql(前端有权限后端再次进行验证permission:admin) -->  对应html章节片段
            let chapterId = data.id//被点击的章节的id
            await this.getChapterContent(this.curArticleId, chapterId)
            this.htmlView=data.content//mysql返回context html章节片段，前端展示

            //nextTick才能获取动态的dom元素
            this.$nextTick(function() {
                let title = document.querySelector(".el-main > div:nth-child(1) span:nth-child(1)")
                title.innerText = data.no + " " + data.label
            })
        },
        printMenu(data) {
            this.str += `<ul>`
            for (let i = 0; i <data.length; i++) {
                this.str += `<li style="list-style: disc;" class="catalog-li"><a v-on:click="aClick()" style="text-decoration:none; " href="#` + data[i].url + `" class="anchor">` + data[i].label +`</a>`
                if (data[i].children!= undefined) {
                    this.printMenu(data[i].children)
                }
                this.str +=`</li>`
            }
            this.str += `</ul>`
            this.menu = this.str
        },
        uploadFile(event) {
            //此处校验文件后缀
            let file = event.target.files[0].name; // (利用console.log输出看file文件对象)json
            let num = file.split('.');
            let mun = num[num.length - 1];
            if (mun === 'html') {
                let _that = this;
                const selectedFile = event.target.files[0]
                // 读取文件名
                const name = selectedFile.name
                _that.articleName = name
                // 读取文件大小
                const size = selectedFile.size
                // FileReader对象，h5提供的异步api，可以读取文件中的数据。
                const reader = new FileReader()
                // readAsText是个异步操作，只有等到onload时才能显示数据。
                reader.readAsText(selectedFile)
                reader.onload = function () {
                    //当读取完成后回调这个函数,然后此时文件的内容存储到了result中,直接操作即可,此处this指向reader，_that指向vue data，this.result就是文件的内容
                    //console.log(this.result)
                    _that.htmlFile = this.result
                    _that.parseHtml(this.result)
                }
            } else {
                this.$message({
                    message: '请重新点击选择文件传入符合标准的文件',
                    type: 'warning'
                });
            }
        },
        parseHtml(dataStr) {

            //let reg = /<div id='write'  class=''>(.*?)<\/div>\n<\/body>/igs
            let reg = /<div id='write'  class=' first-line-indent'>(.*?)<\/div>\n<\/body>/igs
            let ret = reg.exec(dataStr)

            let chapters = []
            //let reg1 = /<h([0-9](.*?) id=(.*?))>(.*?)<h([0-9] id=(.*?))>/igs//文章章节
            let reg1 = /<h(.*?) id=(.*?)>(.*?)<h(.*?) id=(.*?)>/igs//文章章节
            let reg3 = /<h(.*?) id=(.*?)>(.*?)<\/div>\n/igs//由于最后一个章节不符合reg1的格式，所以单独处理，因为一片文章的结束就是用的</div>，因为用</div>去匹配最后一个章节
            let ret2;
            let preIdx;
            let last;
            let len;
            //console.log(ret[0])
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



            //let reg2 = /class="md-header-anchor"><\/a><span>(.*?)<\/span>/is
            let reg2 = /h(.*?) id=(.*?)><span>(.*?)<\/span>/is
            let ret4
            let result = []
            for (let i = 0; i < chapters.length; i++) {
                ret4 = reg2.exec(chapters[i].html)
                result.push({level: chapters[i].level, title: ret4[3], html: chapters[i].html})
            }

            for (let i = 0; i < chapters.length; i++) {
                //console.log(result[i])
            }
            //this.adapter(result)
            this.adapter2(result)
            this.adapterData = result
            this.addArticle()
        },
        adapterNoContent() {
            let data = this.adapterData

            //console.log(data)
            if (data.length <= 0) return

            let data2 = this.addNo(data)//给章节加上编号

            let arr = []
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
            //单调栈：找到每个节点左边第一个比其小的节点(即找到每个节点的父节点)
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

            for (let i = 0; i < arr2.length; i++) {
                //console.log(arr2[i])
            }


            let map = new Map()
            for (let i = 0; i < arr2.length; i++) {
                map.set(arr2[i].id, arr2[i])
            }

            let arr3 = []
            for (let i = 0; i < arr2.length; i++) {
                let obj = arr2[i]
                let obj2 = map.get(obj.pid)
                if (obj2 == null || obj2 == undefined || obj.pid == -1) {
                    arr3.push(obj)
                } else {
                    map.get(obj.pid).children.push(obj)
                }
            }

            //this.data = arr3
            return arr3
        },
        adapter2(data) {
            //console.log(data)
            if (data.length <= 0) return

            let arr = []
            for (let i = 0; i < data.length; i++) {
                let obj = {
                    id: i + 1,
                    level: data[i].level,
                    label: data[i].title,
                    content: data[i].html
                }
                arr.push(obj)
            }

            let arr2 = []
            let pid = -1
            let m = new Map()//level:id
            for (let i = 0; i < arr.length; i++) {
                m.set(arr[i].level, arr[i].id)
                let j;
                for (j = i - 1; j >= 0; j--) {
                    if (arr[j].level != undefined && arr[j].level < arr[i].level)
                    {
                        break;
                    }
                }
                if (j == -1)
                    pid = -1
                else
                {
                    pid = m.get(arr[j].level)
                }

                let obj = {
                    id: arr[i].id,
                    pid: pid,
                    level: arr[i].level,
                    label: arr[i].label,
                    content: arr[i].content,
                    children: []
                }
                arr2.push(obj)
            }

            for (let i = 0; i < arr2.length; i++) {
                //console.log(arr2[i])
            }


            let map = new Map()
            for (let i = 0; i < arr2.length; i++) {
                map.set(arr2[i].id, arr2[i])
            }

            let arr3 = []
            for (let i = 0; i < arr2.length; i++) {
                let obj = arr2[i]
                let obj2 = map.get(obj.pid)
                if (obj2 == null || obj2 == undefined || obj.pid == -1) {
                    arr3.push(obj)
                } else {
                    map.get(obj.pid).children.push(obj)
                }
            }
            this.data = arr3
        },
        addNo(data) {
            let res = []
        
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
                //strNo = strNo.substring(0, strNo.length - 1)
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
        },
        aClick(data) {
            //console.log("gggggggggggggggg" + data)
            this.htmlView = data.content

        },
        addArticle() {
            let that = this;
            //let arr = JSON.stringify(this.data);
            //let p = JSON.parse(arr)

            let data = {
                'articleName': this.articleName,
                'articleMenu': that.adapterNoContent(),
                'article': this.data
            }
            data = JSON.stringify(data)
            request({
              //url: '/article',
              url: '/saveArticle',
              method: 'post',
              //data: this.data
              data: data
            }).then(response => {
                console.log("yyyyyyyyyyyyyy "+ response.data)
                that.updateCurPage()
            });
        },
        article2() {
            let that = this;
            let name = JSON.stringify(this.articleName);
            //文章表
            request({
              url: '/article2',
              method: 'post',
              data: name
            }).then(response => {
                console.log("name"+ response.data)
            });

        },
        getPaper() {
            return request({
              url: '/paper',
              method: 'get'
            });
        },
        getArticleMenu(articleId) {
            let that = this
            that.curArticleId = articleId
            request({
              url: '/articleMenu/' + articleId,
              method: 'get'
            }).then(response => {
                console.log("getArticleMenu() resp:"+ response.data)
                
                that.data = JSON.parse(response.data)
            });
        },
        getChaptersPermissions(articleId) {
            let that = this
            request({
              url: '/chapters/' + articleId,
              method: 'get'
            }).then(response => {
                console.log("getChaptersPermissions() resp:"+ response)
                let arr = response

                that.curChapter2PermissionMap = new Map()
                for (let i = 0; i < arr.length; i++) {
                    //that.curChapter2PermissionMap.push({'chapterId': arr[i].id, 'permission': arr[i].permission})
                    that.curChapter2PermissionMap.set(arr[i].id, arr[i].permission)
                }
                console.log(that.curChapter2PermissionMap)
            });
        },
        getChapterContent(articleId, chapterId) {
            let that = this
            request({
              url: '/article/' + articleId + '/chapter/' + chapterId,
              method: 'get'
            }).then(response => {
                console.log("getChapterContent() resp:"+ response)
                that.htmlView = response
                if (response.length == 0) {
                    console.log("权限不足")
                    that.$modal.msgError("权限不足！请登录或成为vip用户！！");
                    //if (that.userRoleId == 4)//游客
                    //    that.$modal.msgError("权限不足！您的身份是游客！！");
                    //else if (that.userRoleId == 3)//登录
                    //    that.$modal.msgError("权限不足！请成为vip用户！！");
                    //else if (that.userRoleId == 2)//vip
                    //    that.$modal.msgError("权限不足！请成为svip用户！！");
                    //else if (that.userRoleId == 1)//admin
                    //    that.$modal.msgError("权限不足！请联系管理员！！");
                }
            });
        },
        async toPaper(item) {
            this.curArticleTitle = item.title.substring(0, item.title.length - 5)
            await this.getChaptersPermissions(item.articleId)
            await this.getArticleMenu(item.articleId)
            await this.getChapterContent(item.articleId, 1)
        }
    }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
@import '../../../assets/md.css'
</style>
<style>

.file {
    position: relative;
    display: inline-block;
    background: #eef1f6;
    border: 0.1rem solid #99d3f5;
    border-radius: 0.2rem;
    padding: 0.2rem 0.6rem;
    overflow: hidden;
    color: black;
    text-decoration: none;
    text-indent: 0;
    line-height: 1.5rem;
    font-size: 0.8rem;
}
.file input {
    position: absolute;
    font-size: 0.8rem;
    right: 0;
    top: 0;
    opacity: 0;
    cursor: pointer;
}
.file:hover {
    background: #eef1f6;
    border-color: #78c3f3;
    color: green;
    text-decoration: none;
}
</style>
