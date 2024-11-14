<script lang="ts" setup>
import { ref, inject, reactive, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus'
// 引入顶部导航组件
import HeaderComp from '@/components/HeaderComp.vue'
// 引入底部组件
import FooterComp from '@/components/FooterComp.vue'
const axios = inject('axios') //注入 axios
// 顶部导航栏菜单选中索引
const activeIndex = ref('/register')
// 创建路由对象，用于编程式导航
const router = useRouter()
// 以下为表单数据校验代码
interface DataForm {
  uname: string
  upwd: string
  nikename: string
  sex: string
  phone: string
}
const ruleFormRef = ref<FormInstance>()
// 表单数据(注册数据)
const dataForm = reactive<DataForm>({
  uname: '',
  upwd: '',
  nikename: '',
  sex: '男',
  phone: ''
})
// 表单校验规则
const rules = reactive<FormRules<DataForm>>({
  uname: [{ required: true, message: '请输入账号...', trigger: 'blur' }],
  upwd: [{ required: true, message: '请输入密码...', trigger: 'blur' }],
  nikename: [{ required: true, message: '请输入昵称...', trigger: 'blur' }],
  phone: [{ required: true, message: '请输入电话...', trigger: 'blur' }]
})
// 注册按钮事件
const submitForm = async (formEl: FormInstance | undefined) => {
  if (!formEl) return
  await formEl.validate((valid, fields) => {
    if (valid) {
      register() // 用户注册操作
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
// 用户注册函数
function register() {
  axios({
    method: 'post',
    url: '/svr/api/user/register',
    headers: {
      'Content-Type': 'application/json'
    },
    data: dataForm
  })
    .then(function (response) {
      if (response.data.code == '200') {
        // 提示信息
        ElMessage({
          message: '注册成功！',
          type: 'success',
          plain: true
        })
        // 注册成功，跳转至登录页面
        router.push('/login')
      }
    })
    .catch(function (error) {
      ElMessage({
        message: '注册失败！',
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
      <el-divider>用户注册</el-divider>
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
            <el-input v-model="dataForm.uname" />
          </el-form-item>
          <el-form-item label="密码：" prop="upwd">
            <el-input v-model="dataForm.upwd" type="password" show-password />
          </el-form-item>
          <el-form-item label="昵称：" prop="nikename">
            <el-input v-model="dataForm.nikename" />
          </el-form-item>
          <el-form-item label="电话：" prop="phone">
            <el-input v-model="dataForm.phone" />
          </el-form-item>
          <el-form-item label="性别" prop="sex">
            <el-radio-group v-model="dataForm.sex">
              <el-radio value="男">男</el-radio>
              <el-radio value="女">女</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item style="width: 65%; margin: 0 auto">
            <el-button type="primary" @click="submitForm(ruleFormRef)"> 注册 </el-button>
            <el-button @click="resetForm(ruleFormRef)">重置</el-button>
          </el-form-item>
        </el-form>
      </div>
    </el-main>
    <el-footer><FooterComp /></el-footer>
  </el-container>
</template>
