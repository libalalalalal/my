<script lang="ts" setup>
import { ref, inject, onMounted } from 'vue'
import { useRoute, useRouter, RouterLink } from 'vue-router'
// 引入顶部导航组件
import HeaderComp from '@/components/HeaderComp.vue'
// 引入底部组件
import FooterComp from '@/components/FooterComp.vue'
const axios = inject('axios') //注入 axios
// 默认首页导航选中
const activeIndex = ref('/')
// 创建路由对象，用于获取传递的参数
const route = useRoute()
// 搜索栏的关键字
var keyword = ref('')
// 获取传递的过来的关键字
keyword.value = route.params.keyword
// 如果传递的参数值为 all，设置关键字为空字符
if (route.params.keyword == 'all') {
  keyword.value = ''
}
// 查询的数据列表
var seachDatas = ref([])
// 搜索方法
function seach() {
  let data = {
    keyword: keyword.value
  }
  axios({
    method: 'post',
    url: '/svr/api/films/seach-films',
    headers: {
      'Content-Type': 'application/json'
    },
    data: data
  })
    .then(function (response) {
      console.log(response.data)
      if (response.data.code == '200') {
        seachDatas.value = response.data.data
      }
    })
    .catch(function (error) {
      console.log(error)
    })
}
// 完成初始渲染并创建 DOM 节点后，进行页面加载
onMounted(() => {
  seach() // 查询操作
})
</script>
<template>
  <el-container>
    <el-header>
      <HeaderComp :active-index="activeIndex" />
    </el-header>
    <el-main>
      <div class="mt-4">
        <el-input
          style="max-width: 600px"
          v-model="keyword"
          placeholder="请输入搜索关键字......"
          clearable
        >
          <template #prefix>
            <el-icon class="el-input__icon"><search /></el-icon>
          </template>
          <template #append>
            <el-button @click="seach">搜 索</el-button>
          </template>
        </el-input>
      </div>
      <el-divider>搜索结果</el-divider>
      <div class="mt-4 text-sm font-bold">
        <el-row justify="center" :gutter="5">
          <el-col :span="4" v-for="item in seachDatas" :key="item.fid">
            <el-card style="padding: '0px'">
              <template #header>{{ item.title }}</template>
              <RouterLink :to="String('/fil/' + item.fid) + String('/') + item.tid">
                <img
                  :src="String('/svr/api/image/display/fil/') + item.cover"
                  style="width: 100%; display: block"
                />
              </RouterLink>
            </el-card>
          </el-col>
        </el-row>
      </div>
    </el-main>
    <el-footer><FooterComp /></el-footer>
  </el-container>
</template>
