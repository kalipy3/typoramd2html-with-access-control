<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!--用户数据-->
      <el-col :span="20" :xs="24">
        <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
          <el-form-item label="文章名" prop="title">
            <el-input
              v-model="queryParams.title"
              placeholder="请输入文章名"
              clearable
              style="width: 240px"
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <!--<el-form-item label="创建时间">
            <el-date-picker
              v-model="dateRange"
              style="width: 240px"
              value-format="yyyy-MM-dd"
              type="daterange"
              range-separator="-"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
            ></el-date-picker>
          </el-form-item>-->
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
              type="info"
              plain
              icon="el-icon-upload2"
              size="mini"
              @click="handleImport"
              v-hasPermi="['system:user:import']"
            >上传</el-button>
          </el-col>
          <!--
          <el-col :span="1.5">
            <el-button
              type="warning"
              plain
              icon="el-icon-download"
              size="mini"
              @click="handleExport"
              v-hasPermi="['system:user:export']"
            >下载</el-button>
          </el-col>-->
          <el-col :span="1.5">
            <el-button
              type="danger"
              plain
              icon="el-icon-delete"
              size="mini"
              :disabled="multiple"
              @click="handleDelete"
              v-hasPermi="['system:user:remove']"
            >删除</el-button>
          </el-col>
          <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" :columns="columns"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="paperList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="文章编号" align="center" key="articleId" prop="articleId" v-if="columns[0].visible" />
              <el-table-column label="文章名" align="center" key="title" v-if="columns[1].visible" :show-overflow-tooltip="true">
                      <template slot-scope="scope">{{scope.row.title.substring(0, scope.row.title.length - 5)}}</template>
              <!--
          <el-table-column label="创建时间" align="center" prop="createTime" v-if="columns[2].visible" width="160">
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
            </template>
              -->
             </el-table-column>
          <el-table-column
            label="操作"
            align="center"
            width="160"
            class-name="small-padding fixed-width"
          >
            <template slot-scope="scope">
              <el-button
                size="mini"
                type="text"
                icon="el-icon-edit"
                @click="handleUpdate(scope.row)"
                v-hasPermi="['system:user:edit']"
              >修改</el-button>
              <el-button
                size="mini"
                type="text"
                icon="el-icon-delete"
                @click="handleDelete(scope.row)"
                v-hasPermi="['system:user:remove']"
              >删除</el-button>
            </template>
          </el-table-column>
        </el-table>

        <pagination
          v-show="total>0"
          :total="total"
          :page.sync="queryParams.pageNum"
          :limit.sync="queryParams.pageSize"
          @pagination="getList"
        />
      </el-col>
    </el-row>

    <!-- 修改用户配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="文章名" prop="title">
              <el-input v-model="form.title" placeholder="请输入文章名" maxlength="30" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 用户上传对话框 -->
    <el-dialog :title="upload.title" :visible.sync="upload.open" width="400px" append-to-body>
      <el-upload
        ref="upload"
        :limit="1"
         :before-upload="uploadFilePrepare"
        accept=".zip"
        :headers="upload.headers"
        :action="upload.url + '?updateSupport=' + upload.updateSupport"
        :disabled="upload.isUploading"
        :on-progress="handleFileUploadProgress"
        :on-success="handleFileSuccess"
        :auto-upload="false"
        drag
      >
        <i class="el-icon-upload"></i>
        <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
        <div class="el-upload__tip text-center" slot="tip">
            <!--
          <div class="el-upload__tip" slot="tip">
            <el-checkbox v-model="upload.updateSupport" /> 是否更新已经存在的用户数据
          </div>
            -->
          <span>仅允许上传zip文件。</span>
          <!--
          <el-link type="primary" :underline="false" style="font-size:12px;vertical-align: baseline;" @click="importTemplate">下载模板</el-link>
          -->
        </div>
      </el-upload>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFileForm">确 定</el-button>
        <el-button @click="upload.open = false">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listUser, getUser, addUser, resetUserPwd, changeUserStatus } from "@/api/system/user";
import { getToken } from "@/utils/auth";
import request from '../../../utils/request'
import jsZip from 'jszip'

export default {
  name: "User",
  dicts: ['sys_normal_disable', 'sys_user_sex'],
  components: { },
  data() {
    return {
        ruoyiImgPath: null,
        preFile: null,
        articleName: "",
        adapterData: [],
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 用户表格数据
      paperList: null,
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 日期范围
      dateRange: [],
      // 表单参数
      form: {},
      defaultProps: {
        children: "children",
        label: "label"
      },
      // 用户上传参数
      upload: {
        // 是否显示弹出层（用户上传）
        open: false,
        // 弹出层标题（用户上传）
        title: "",
        // 是否禁用上传
        isUploading: false,
        // 是否更新已经存在的用户数据
        updateSupport: 0,
        // 设置上传的请求头部
        headers: { Authorization: "Bearer " + getToken() },
        // 上传的地址
        url: process.env.VUE_APP_BASE_API + "/paper/upload"
      },
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        title: undefined
      },
      // 列信息
      columns: [
        { key: 0, label: `文章编号`, visible: true },
        { key: 1, label: `文章名`, visible: true },
        { key: 2, label: `创建时间`, visible: true }
      ],
      // 表单校验
      rules: {
        title: [
          { required: true, message: "文章名不能为空", trigger: "blur" },
          { min: 2, max: 20, message: '文章名长度必须介于 2 和 20 之间', trigger: 'blur' }
        ]
      }
    };
  },
  watch: {
  },
  async created() {
    await this.getList();
  },
  methods: {
    delPaper(articleId) {
      return request({
        url: '/paper/' + articleId,
        method: 'delete'
      })
    },
    updatePaper(data) {
      return request({
        url: '/paper',
        method: 'put',
        data: data
      })
    },
    /** 查询用户列表 */
    async getList() {
      this.loading = true;
      await this.getPaper();
    },
    getPaper() {
        return request({
          url: '/paper/list',
          method: 'get',
          params: this.queryParams
        }).then(response => {
          this.paperList = response.rows;
          this.total = response.total;
          this.loading = false;
        }
      );
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        articleId: undefined,
        title: undefined
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.dateRange = [];
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.articleId);
      this.single = selection.length != 1;
      this.multiple = !selection.length;
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
        console.log("row:"+row.articleId)
      this.reset();
      const articleId = row.articleId || this.ids;
        const title = row.title
      //getUser(articleId).then(response => {
      //  this.form = response.data;
      //  this.open = true;
      //  this.title = "修改文章";
      //});
        this.form = {
          articleId: articleId,
          title: title.substring(0, title.length - 5)//去掉.html后缀
        };
        this.open = true;
        this.title = "修改文章";
    },
    /** 提交按钮 */
    submitForm: function() {
        let that = this
      this.$refs["form"].validate(valid => {
        if (valid) {
            let form = {
              articleId: that.form.articleId,
              title: that.form.title + ".html"
            };
            console.log(form)
          if (this.form.articleId != undefined) {
            that.updatePaper(form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              that.getList();
            }, error => {
             if (error.code != 200) {
                 this.$message.error('修改失败 请检查文件名是否重名!');
                 return;
             }
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
        let that = this
      const articleIds = row.articleId || this.ids;
      this.$modal.confirm('是否确认删除文章编号为"' + articleIds + '"的数据项？').then(function() {
        console.log(row)
        //return delUser(articleIds);
        return that.delPaper(articleIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 下载按钮操作 */
    handleExport() {
      this.download('system/user/export', {
        ...this.queryParams
      }, `user_${new Date().getTime()}.xlsx`)
    },
    /** 上传按钮操作 */
    handleImport() {
      this.upload.title = "文章上传";
      this.upload.open = true;
    },
    /** 下载模板操作 */
    importTemplate() {
      this.download('system/user/importTemplate', {
      }, `user_template_${new Date().getTime()}.xlsx`)
    },
    // 文件上传中处理
    handleFileUploadProgress(event, file, fileList) {
      this.upload.isUploading = true;
        console.log("上传中")
    },
    // 文件上传成功处理
    async handleFileSuccess(response, file, fileList) {
    let that = this;
      this.upload.open = false;
      this.upload.isUploading = false;
      this.$refs.upload.clearFiles();
        if (response.code != 200) {
                this.$message({
                  message: '失败！请检测文件名是否重复！',
                  type: 'error'
                });
            return;
        }

        that.ruoyiImgPath = response.filePath.substring(response.filePath.lastIndexOf("/") , response.filePath.length)
        console.log("9999999999999:"+that.ruoyiImgPath)
        await this.uploadFile()

      //this.$alert("<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" + response.msg + "</div>", "上传结果", { dangerouslyUseHTMLString: true });


      //this.getList();
    },
    // 提交上传文件
    submitFileForm() {
      this.$refs.upload.submit();
    },
    uploadFilePrepare(file) {
        this.preFile = file
    },
    async uploadFile() {
        let file = this.preFile
        let that = this
        console.log("上传前")
        let jszip = new jsZip();
        console.log(file.name)
    
        await jszip.loadAsync(file).then(async (zip) => { // 读取zip
            for (let key in zip.files) { 
                // 判断是否是目录
                if (!zip.files[key].dir) {
                    // 判断是否是html文件
                    if (/\.(html)$/.test(zip.files[key].name)) { 
                        let base = zip.file(zip.files[key].name).async(
        'string') // 以字符串形式输出文本内容
                        return base.then(async res => {
                            that.articleName = zip.files[key].name
                            await that.parseHtml(res, file.name.substring(0, file.name.length - 4))//typora-html2md.zip
                        })
                    }
                } else {//是目录
                    
                }
            }
        })
    },
        async parseHtml(dataStr, htmlFileName) {
            //http://127.0.0.1:9999/profile/upload/typora-html2md/img/http.png
            //http://127.0.0.1:8088/profile/upload/typora-html2md/img/http.png
            //let imgPath = "./profile/upload/" + htmlFileName + "/img"//若依后端文件上传的路径
            let imgPath = "./profile/upload" + this.ruoyiImgPath + "/img"//若依后端文件上传的路径
            dataStr = dataStr.replace(/img src=\"\.\/img/g, 'img src="' + imgPath)

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
            this.adapter2(result)
            this.adapterData = result
            await this.addArticle()

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
                    label: data2[i].title
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

            return arr3//gg
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
        async addArticle() {
            let that = this;

            let data = {
                'articleName': this.articleName,
                'articleMenu': that.adapterNoContent(),
                'article': that.adapter2(that.adapterData)
            }
            data = JSON.stringify(data)
            return request({
              url: '/saveArticle',
              method: 'post',
              data: data
            }).then(response => {
                console.log("yyyyyyyyyyyyyy "+response)
                if (response == 0)
                {
                    this.$alert("<div style='overflow: auto;overflow-x: hidden;max-height: 70vh;padding: 10px 20px 0;'>" + "上传成功" + "</div>", "上传结果", { dangerouslyUseHTMLString: true });
                    that.getList()
                    console.log("上传成功")
                }
                //if (response.code == 500) {//sql出错这里将执行不到
                //    console.log("请检查文件名是否重名!")
                //}
                //if (response != 0)
                //{
                //    this.$message.error('请检查文件名是否重名!');
                //    that.$refs.upload.abort();//取消上传
                //}
            }, error => {
                that.$message.error('失败！请检查文件名是否重名!');
            });
        },
  }
};
</script>
