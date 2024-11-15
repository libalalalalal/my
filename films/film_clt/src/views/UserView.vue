<script lang="ts" setup>
import { ref, inject, reactive, onMounted } from 'vue'
import { useRoute, useRouter, RouterLink } from 'vue-router'
import type { FormInstance, FormRules } from 'element-plus'
import type { UploadProps } from 'element-plus'
import { ElMessage } from 'element-plus'
// 引入顶部导航组件
import HeaderComp from '../components/HeaderComp.vue'
// 引入底部组件
import FooterComp from '../components/FooterComp.vue'
// 引入侧边组件
import AsideComp from '../components/AsideComp.vue'
// 引入状态管理文件
import { useTokenStore } from '../stores/token'
const axios = inject('axios') //注入 axios
// 创建路由对象，用于编程式导航
const router = useRouter()
// 创建 Token 状态管理 Store
const userStore = useTokenStore()
// 获取登录的 Token
const token = ref(userStore.getToken())
// 导航栏菜单选中索引
const activeIndex = ref('/user')
// 侧边栏菜单选中索引
const asideIndex = ref('/user')
// 用户数据
var user = ref({})
// 头像 Url
const avatarUrl = ref('/svr/api/image/display/head/tx.png')
// 以下为表单数据校验代码
interface DataForm {
  nikename: string
  sex: string
  phone: string
  avatar: string
}
const ruleFormRef = ref<FormInstance>()
// 表单数据(用户数据)
const dataForm = reactive<DataForm>({
  nikename: '',
  sex: '男',
  phone: '',
  avatar: 'tx.png'
})
// 表单校验规则
const rules = reactive<FormRules<DataForm>>({
  nikename: [{ required: true, message: '请输入昵称...', trigger: 'blur' }],
  phone: [{ required: true, message: '请输入电话...', trigger: 'blur' }]
})
// 修改按钮事件
const submitForm = async (formEl: FormInstance | undefined) => {
  if (!formEl) return
  await formEl.validate((valid, fields) => {
    if (valid) {
      console.log('submit!')
      // 修改用户信息
      editUser()
    } else {
      console.log('error submit!', fields)
    }
  })
}
// 重置按钮事件
const resetForm = (formEl: FormInstance | undefined) => {
  if (!formEl) return
  formEl.resetFields()
}
// 调用 API 接口，获取当前登录用户
function initUser() {
  // 判断 Token 是否存在
  if (token.value != '') {
    axios({
      method: 'get',
      url: '/svr/api/user/get-user',
      headers: {
        Authorization: 'Bearer ' + token.value
      }
    })
      .then(function (response) {
        // console.log(response.data)
        if (response.data.code == '200') {
          user.value = response.data.data
          // 初始化表单数据
          dataForm.nikename = user.value.nikename
          dataForm.phone = user.value.phone
          dataForm.sex = user.value.sex
          avatarUrl.value = '/svr/api/image/display/head/' + user.value.avatar
        }
      })
      .catch(function (error) {
        console.log(error)
        // 鉴权判断
        if (error.response.status == 401) {
          // 没有权限或已过期，设置 token 为空
          token.value = ''
          userStore.setToken('')
          // 提示信息
          ElMessage({
            message: '请重新登录！',
            type: 'success',
            plain: true
          })
        }
      })
  }
}
// 上传头像成功的回调函数
const handleAvatarSuccess: UploadProps['onSuccess'] = (response, uploadFile) => {
  // 设置新头像 URL
  avatarUrl.value = URL.createObjectURL(uploadFile.raw!)
  // 更新用户数据的头像名称
  dataForm.avatar = response.upFile
}
// 上传头像前的回调函数
const beforeAvatarUpload: UploadProps['beforeUpload'] = (rawFile) => {
  // 获取上传头像的后缀
  const fileSuffix = rawFile.name.substring(rawFile.name.lastIndexOf('.') + 1).toLowerCase()
  //允许上传的头像扩展名的集合
  const whiteList = ['png', 'gif', 'jpg', 'webp', 'jpeg']
  // 判断头像是否允许上传
  if (whiteList.indexOf(fileSuffix) === -1) {
    ElMessage.error('头像只能是：png, gif, jpg, webp, jpeg 格式')
    return false
  }
  // 判断头像大小是否符合要求
  if (rawFile.size / 1024 / 1024 > 2) {
    ElMessage.error('头像大小不能超过 2MB!')
    return false
  }
  return true
}
// 修改用户信息
function editUser() {
  axios({
    method: 'post',
    url: '/svr/api/user/update-user',
    headers: {
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + token.value
    },
    data: dataForm
  })
    .then(function (response) {
      if (response.data.code == '200') {
        // 提示信息
        ElMessage({
          message: '修改成功！',
          type: 'success',
          plain: true
        })
      }
    })
    .catch(function (error) {
      // 鉴权判断
      if (error.response.status == 401) {
        // 设置当前登录用户的 token 为空
        token.value = ''
        userStore.setToken('')
        // 提示信息
        ElMessage({
          message: '请重新登录！',
          type: 'success',
          plain: true
        })
      }
    })
}
// 完成初始渲染并创建 DOM 节点后，进行页面加载
onMounted(() => {
  // 初始化用户数据
  initUser()
})
</script>
<template>
  <el-container>
    <el-header>
      <HeaderComp :active-index="activeIndex" />
    </el-header>
    <el-container>
      <el-aside width="200px">
        <!--侧边导航组件-->
        <AsideComp :aside-index="asideIndex" />
      </el-aside>
      <el-container>
        <el-main>
          <div>
            <!-- 用户信息开始 -->
            <el-page-header>
              <template #icon>
                <el-icon><User /></el-icon>
              </template>
              <template #title>用户信息</template>
              <div style="display: flex; justify-content: center; margin-top: 10px">
                <el-form
                  ref="ruleFormRef"
                  style="max-width: 600px"
                  :model="dataForm"
                  :rules="rules"
                  label-width="auto"
                  status-icon
                >
                  <el-form-item label="头像">
                    <!-- 头像上传组件开始 -->
                    <el-upload
                      class="avatar-uploader"
                      name="file"
                      action="/svr/api/user/upload"
                      :show-file-list="false"
                      :on-success="handleAvatarSuccess"
                      :before-upload="beforeAvatarUpload"
                    >
                      <img
                        v-if="avatarUrl"
                        :src="avatarUrl"
                        style="width: 100px; height: 100px"
                        class="avatar"
                      />
                      <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
                    </el-upload>
                    <!-- 头像上传组件结束 -->
                  </el-form-item>
                  <el-form-item label="昵称" prop="nikename">
                    <el-input v-model="dataForm.nikename" />
                  </el-form-item>
                  <el-form-item label="电话" prop="phone">
                    <el-input v-model="dataForm.phone" />
                  </el-form-item>
                  <el-form-item label="性别" prop="sex">
                    <el-radio-group v-model="dataForm.sex">
                      <el-radio value="男">男</el-radio>
                      <el-radio value="女">女</el-radio>
                    </el-radio-group>
                  </el-form-item>
                  <el-form-item>
                    <el-button type="primary" @click="submitForm(ruleFormRef)"> 修改 </el-button>
                    <el-button @click="resetForm(ruleFormRef)">取消</el-button>
                  </el-form-item>
                </el-form>
              </div>
            </el-page-header>
            <!-- 用户信息开始 -->
          </div>
        </el-main>
        <el-footer>
          <el-footer><FooterComp /></el-footer>
        </el-footer>
      </el-container>
    </el-container>
  </el-container>
</template>
<style>
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}
.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}
.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  text-align: center;
}
</style>
