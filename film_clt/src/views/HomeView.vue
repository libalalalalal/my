<template>
  <el-container>
    <!--顶部导航栏-->
    <el-header>
      <HeaderComp :active-index="activeIndex" />
    </el-header>
    <!--主要区域容器-->
    <el-main>
      <el-divider border-style="dashed" />
      <!--搜索栏开始-->
      <div class="search-bar">
        <el-input
          class="search-input"
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
      <el-divider border-style="dotted" />
      <!--轮播图开始-->
      <el-carousel :interval="4000" type="card" height="240px" class="carousel-wrapper">
        <el-carousel-item v-for="item in carouselDatas" :key="item.fid">
          <RouterLink :to="String('/fil/' + item.fid) + String('/') + item.tid">
            <el-image
              class="carousel-image"
              :src="String('/svr/api/image/display/fil/') + item.cover"
              fit="cover"
            />
          </RouterLink>
        </el-carousel-item>
      </el-carousel>
      <!--轮播图结束-->

      <!--搜索栏结束-->
      <!--文学推荐栏开始-->
      <div v-for="item in recommendDatas" :key="item.tid" class="recommend-section">
        <div class="recommend-header">
          <el-avatar
            :size="40"
            class="mr-3"
            :src="String('/svr/api/image/display/head/') + item.cover"
            style="vertical-align: middle"
          />
          <span class="recommend-title"> {{ item.name }} </span>
          <el-button class="more-button" @click="goClassics(item.tid)">
            <el-icon><DArrowRight /></el-icon>
            查看更多
          </el-button>
        </div>
        <div class="recommend-content">
          <el-row justify="center" :gutter="20">
            <el-col :span="4" v-for="film in item.films" :key="film.fid">
              <el-card class="recommend-card">
                <template #header>{{ film.title }}</template>
                <RouterLink :to="String('/fil/' + film.fid) + String('/') + film.tid">
                  <img
                    class="recommend-image"
                    :src="String('/svr/api/image/display/fil/') + film.cover"
                  />
                </RouterLink>
              </el-card>
            </el-col>
          </el-row>
        </div>
        <el-divider border-style="dotted" />
      </div>
      <!--文学推荐栏结束-->
    </el-main>
    <!--底部导航栏-->
    <el-footer><FooterComp /></el-footer>
  </el-container>
</template>

<script lang="ts" setup>
import { ref, inject, onMounted } from 'vue'
import { useRoute, useRouter, RouterLink } from 'vue-router'
// 引入顶部导航组件
import HeaderComp from '../components/HeaderComp.vue'
// 引入底部组件
import FooterComp from '../components/FooterComp.vue'
// 导航栏菜单选中索引，默认选中首页
const activeIndex = ref('/')
const axios = inject('axios') //注入 axios
// 轮播图数据列表
var carouselDatas = ref([])

// 调用 API 接口，获取轮播图列表，用于初始化首页轮播图
function initCarousel() {
  axios({
    method: 'get',
    url: '/svr/api/films/seach-carousels/6'
  })
    .then(function (response) {
      if (response.data.code == '200') {
        carouselDatas.value = response.data.data
      }
    })
    .catch(function (error) {
      console.log(error)
    })
}
// 创建路由对象，用于编程式导航
const router = useRouter()
// 搜索栏的关键字
const keyword = ref('')
// 搜索跳转方法，跳转至搜索页
function seach() {
  // 获取输入的搜索关键字
  var mykeyword = keyword.value
  // 当搜索关键字为空时，设置值为：all(搜索所有内容)
  if (keyword.value == '') {
    mykeyword = 'all'
  }
  // 跳转至搜索页面，并传递关键字
  router.push({ name: 'seach', params: { keyword: mykeyword } })
}
// 文学推荐数据列表
var recommendDatas = ref([])
// 调用 API 接口，获取推荐的文学列表，用于初始化首推荐栏目
function initRecommend() {
  axios({
    method: 'get',
    url: '/svr/api/films/recommend-films/6'
  })
    .then(function (response) {
      console.log(response.data)
      if (response.data.code == '200') {
        recommendDatas.value = response.data.data
      }
    })
    .catch(function (error) {
      console.log(error)
    })
}

// 跳转至文学列表
const goClassics = (tid) => {
  // console.log('go goClassics')
  router.push({ name: 'fillist', params: { tid: tid } })
}

// 完成初始渲染并创建 DOM 节点后，进行页面加载
onMounted(() => {
  // 初始化轮播图
  initCarousel()
  initRecommend() // 初始化文学推荐栏目
})
</script>

<style scoped>
/* 轮播图样式 */
.carousel-wrapper {
  border-radius: 10px;
  overflow: hidden;
}

.carousel-image {
  width: 100%;
  height: 240px;
  object-fit: cover;
  border-radius: 10px;
}

/* 搜索栏样式 */
.search-bar {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.search-input {
  max-width: 600px;
  width: 100%;
}

/* 文学推荐栏样式 */
.recommend-section {
  margin-bottom: 20px;
}

.recommend-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.recommend-title {
  font-size: 1.2em;
  font-weight: bold;
}

.more-button {
  margin-left: auto;
}

.recommend-content {
  margin-top: 10px;
}

.recommend-card {
  padding: 0;
}

.recommend-image {
  width: 100%;
  display: block;
  border-radius: 5px;
}
</style>
