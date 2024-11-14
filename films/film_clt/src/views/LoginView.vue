<script lang="ts" setup>
import { ref, inject, reactive, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus'
import { useTokenStore } from '../stores/token'
// 引入顶部导航组件
import HeaderComp from '../components/HeaderComp.vue'
// 引入底部组件
import FooterComp from '../components/FooterComp.vue'
const axios = inject('axios') //注入 axios
// 顶部导航栏菜单选中索引
const activeIndex = ref('/login')
// 创建 Token 状态管理 Store
const userStore = useTokenStore()
// 创建路由对象，用于编程式导航
const router = useRouter()
// 以下为表单数据校验代码
interface DataForm {
  uname: string
  upwd: string
}
const ruleFormRef = ref<FormInstance>()
// 表单数据(登录数据)
const dataForm = reactive<DataForm>({
  uname: '',
  upwd: ''
})
// 表单校验规则
const rules = reactive<FormRules<DataForm>>({
  uname: [{ required: true, message: '请输入账号...', trigger: 'blur' }],
  upwd: [{ required: true, message: '请输入密码...', trigger: 'blur' }]
})
// 登录按钮事件
const submitForm = async (formEl: FormInstance | undefined) => {
  if (!formEl) return
  await formEl.validate((valid, fields) => {
    if (valid) {
      login() // 用户注册操作
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
// 用户登录函数
function login() {
  axios({
    method: 'post',
    url: '/svr/api/user/login',
    headers: {
      'Content-Type': 'application/json'
    },
    data: dataForm
  })
    .then(function (response) {
      console.log(response.data)
      if (response.data.code == '200') {
        // 提示信息
        ElMessage({
          message: '登录成功！',
          type: 'success',
          plain: true
        })
        // 获取登录的 Token，并存储至状态管理变量 store 中
        let token = response.data.token
        userStore.setToken(token)
        // 登录成功，跳转至主页
        router.push('/')
      } else {
        ElMessage({
          message: '登录失败！',
          type: 'error',
          plain: true
        })
      }
    })
    .catch(function (error) {
      console.log(error)
      ElMessage({
        message: '登录失败！',
        type: 'error',
        plain: true
      })
    })
}
</script>
<template>
  <el-container>
    <el-header>
      <HeaderComp :active-index="activeIndex" />
    </el-header>
    <el-main>
      <el-divider>用户登录</el-divider>
      <div style="display: flex; justify-content: center">
        <el-form
          ref="ruleFormRef"
          style="max-width: 600px"
          :model="dataForm"
          :rules="rules"
          label-width="auto"
          status-icon
        >
          <el-form-item label="账号：" prop="uname">
            <el-input v-model="dataForm.uname">
              <template #suffix>
                <el-icon class="el-input__icon"><User /></el-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item label="密码：" prop="upwd">
            <el-input v-model="dataForm.upwd" type="password" show-password />
          </el-form-item>
          <el-form-item style="width: 65%; margin: 0 auto">
            <el-button type="primary" @click="submitForm(ruleFormRef)"> 登录 </el-button>
            <el-button @click="resetForm(ruleFormRef)">重置</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-main>
    <el-footer><FooterComp /></el-footer>
  </el-container>
</template>
