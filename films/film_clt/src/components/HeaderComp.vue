<script lang="ts" setup>
import { ref, inject, onMounted } from 'vue'
import { useTokenStore } from '../stores/token'
// 创建 Token 状态管理 Store
const userStore = useTokenStore()
// 获取登录的 Token
const token = ref(userStore.getToken())

// 构建 logo 图片及用户中心默认图片的 URL
const logo_url = ref('/svr/api/image/display/head/logo.png')
const user_url = ref('/svr/api/image/display/head/tx.png')

const axios = inject('axios') //注入 axios
// 用于接收传递给组件的数据，此处传递的是选中的菜单索引
const props = defineProps({ activeIndex: String })
// 设置菜单选中索引
const activeIndex = props.activeIndex
// 导航栏数据列表
var navDatas = ref([])
// 调用 API 接口，获取文学类型列表，用于初始化导航栏
function initNav() {
  axios({
    method: 'get',
    url: '/svr/api/films/get-filmtypes'
  })
    .then(function (response) {
      if (response.data.code == '200') {
        navDatas.value = response.data.data
      }
    })
    .catch(function (error) {
      console.log(error)
    })
}
// 调用 API 接口，获取当前登录用户
function initAvatar() {
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
        console.log(response.data)
        if (response.data.code == '200') {
          let user = response.data.data
          user_url.value = '/svr/api/image/display/head/' + user.avatar
        }
      })
      .catch(function (error) {
        console.log(error)
        // 鉴权判断
        if (error.response.status == 401) {
          // 没有权限或已过期，设置 token 为空
          user_url.value = '/svr/api/image/display/head/tx.png'
          token.value = ''
          userStore.setToken('')
        }
      })
  }
}
// 完成初始渲染并创建 DOM 节点后，进行页面加载
onMounted(() => {
  initNav() // 初始化导航栏
  // 初始化导航栏头像
  initAvatar()
})
</script>
<template>
  <!--导航标签开始-->
  <el-menu
    :default-active="activeIndex"
    :router="true"
    class="el-menu-demo"
    mode="horizontal"
    :ellipsis="false"
  >
    <el-menu-item index="">
      <img style="width: 60px; height: 60px" :src="logo_url" alt="古典文学" />
    </el-menu-item>
    <el-menu-item index="/">首页</el-menu-item>
    <el-menu-item
      v-for="item in navDatas"
      :key="item.tid"
      :index="String('/fillist/') + item.tid"
      >{{ item.name }}</el-menu-item
    >
    <div class="flex-grow" />
    <el-menu-item v-if="token == ''" index="/register">注册</el-menu-item>
    <el-menu-item v-if="token == ''" index="/login">登录</el-menu-item>
    <el-sub-menu v-if="token != ''" index="">
      <template #title>
        <el-avatar size="small" :src="user_url" />
      </template>
      <el-menu-item index="/user">用户中心</el-menu-item>
      <el-menu-item index="/out">退出</el-menu-item>
    </el-sub-menu>
  </el-menu>
  <!--导航标签结束-->
</template>
<style>
.flex-grow {
  flex-grow: 1;
}
</style>
