<script lang="ts" setup>
import { ref, watch } from 'vue'
import { useRoute, RouterLink } from 'vue-router'
import { inject } from 'vue'
// 引入顶部导航组件
import HeaderComp from '../components/HeaderComp.vue'
// 引入底部组件
import FooterComp from '../components/FooterComp.vue'
const axios = inject('axios') //注入 axios
// 创建路由对象
const route = useRoute()
// 电影类型编号
const tid = ref('')
// 电影数据列表
var filDatas = ref({})
tid.value = route.params.tid
watch(
  () => route.params,
  (newValue, oldValue) => {
    tid.value = newValue.tid
    initFilList() // 初始化电影列表
  },
  // immediate: true 选项来强制侦听器的回调立即执行
  { immediate: true }
)
// 导航栏菜单选中索引
const activeIndex = ref('/fillist/' + route.params.tid)
// 调用 API 接口，获取电影列表
function initFilList() {
  axios({
    method: 'get',
    url: '/svr/api/films/get-films/' + tid.value
  })
    .then(function (response) {
      if (response.data.code == '200') {
        filDatas.value = response.data.data
      }
    })
    .catch(function (error) {
      console.log(error)
    })
}
</script>
<template>
  <el-container>
    <el-header>
      <HeaderComp :active-index="activeIndex" />
    </el-header>
    <el-main>
      <div>
        <!-- 电影列表开始 -->
        <el-page-header>
          <template #icon>
            <el-avatar
              :size="30"
              class="mr-3"
              :src="String('/svr/api/image/display/head/') + filDatas.cover"
              style="vertical-align: middle"
            />
          </template>
          <template #title>{{ filDatas.name }}</template>
          <div class="mt-4 text-sm font-bold">
            <el-row justify="center" :gutter="5">
              <el-col :span="4" v-for="item in filDatas.films" :key="item.fid">
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
        </el-page-header>
        <!-- 电影列表结束 -->
        <el-divider border-style="dotted" />
      </div>
    </el-main>
    <el-footer><FooterComp /></el-footer>
  </el-container>
</template>
