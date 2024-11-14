<template>
  <el-container>
    <el-header>
      <HeaderComp :active-index="activeIndex" />
    </el-header>
    <el-main>
      <el-row>
        <!-- 左侧展示电影信息和图片 -->
        <el-col :span="16" style="border: 2px solid #909399; padding: 15px;">
          <el-result :title="filData.title">
            <template #icon>
              <el-image
                style="width: 100%; height: 300px"
                :src="String('/svr/api/image/display/fil/') + filData.cover"
                fit="contain"
              />
            </template>
            <template #sub-title>
              <el-text>{{ filData.author }}（{{ filData.year }}）</el-text><br />
              <el-text>评价：</el-text>
              <el-rate v-if="token == ''" disabled v-model="star" @change="judgeFil" />
              <el-rate v-if="token != ''" v-model="star" @change="judgeFil" />
            </template>
            <template #extra>
              <el-row><div v-html="filData.describes"></div></el-row>
            </template>
          </el-result>
        </el-col>
        <!-- 右侧展示影评信息 -->
        <el-col :span="8" style="border: 2px solid #909399; padding: 15px;">
          <div style="margin: auto">
            <el-divider>影评信息({{ filData.commentscount }}条)</el-divider>
            <el-descriptions v-for="item in disDatas" :key="item.did" class="margin-top" :column="1">
              <template #title>
                <el-avatar
                  :size="35"
                  :src="String('/svr/api/image/display/head/') + item.user.avatar"
                  style="vertical-align: middle"
                />
                <el-text class="mx-1" type="primary" size="large" style="margin-left: 5px">
                  {{ item.user.nikename }}
                </el-text>
              </template>
              <template #extra>
                <!-- 影评评价开始 -->
                <!-- 已登录，可以进行评价 -->
                <el-button-group v-if="token != ''" class="ml-4">
                  <el-button type="danger" @click="judgeDiscus(item.did, 1)">
                    <el-icon><Upload /></el-icon>顶（{{ item.topcount }}）
                  </el-button>
                  <el-button type="danger" @click="judgeDiscus(item.did, 0)">
                    <el-icon><Download /></el-icon>踩（{{ item.lowcount }}）
                  </el-button>
                </el-button-group>
                <!-- 没有登录，评价按钮被禁用 -->
                <el-button-group v-if="token == ''" class="ml-4">
                  <el-button type="danger" disabled>
                    <el-icon><Upload /></el-icon>顶（{{ item.topcount }}）
                  </el-button>
                  <el-button type="danger" disabled>
                    <el-icon><Download /></el-icon>踩（{{ item.lowcount }}）
                  </el-button>
                </el-button-group>
                <!-- 影评评价结束 -->
              </template>
              <el-descriptions-item>
                <div style="margin-left: 80px">
                  <el-text class="mx-1" size="large">{{ item.comment }}</el-text>
                </div>
              </el-descriptions-item>
            </el-descriptions>
          </div>
          <!-- 发表影评开始 -->
          <div v-if="token != ''" style="margin-top: 20px; text-align: center">
            <el-divider>发表影评</el-divider>
            <el-input
              v-model="comment"
              style="width: 80%"
              :autosize="{ minRows: 2, maxRows: 4 }"
              type="textarea"
              placeholder="请输入评论信息..."
            /><br />
            <el-button style="margin-top: 5px" type="primary" @click="pubDiscuss"> 发表影评 </el-button>
          </div>
          <!-- 发表影评结束 -->
        </el-col>
      </el-row>
    </el-main>
    <el-footer><FooterComp /></el-footer>
  </el-container>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'
import { useRoute } from 'vue-router'
import { inject } from 'vue'
import { ElMessage } from 'element-plus'
import { useTokenStore } from '@/stores/token'
// 引入顶部导航组件
import HeaderComp from '../components/HeaderComp.vue'
// 引入底部组件
import FooterComp from '../components/FooterComp.vue'
const userStore = useTokenStore()
const token = ref(userStore.getToken())

const axios = inject('axios')
const route = useRoute()

const fid = ref('')
const tid = ref('')
const filData = ref({})
const comment = ref('')
const star = ref(0)

fid.value = route.params.fid
tid.value = route.params.tid

const activeIndex = ref('/fillist/' + route.params.tid)

watch(
  () => route.params,
  (newValue, oldValue) => {
    fid.value = newValue.fid
    tid.value = newValue.tid
    initFil()
    initDis()
  },
  { immediate: true }
)

function initFil() {
  axios({
    method: 'get',
    url: '/svr/api/films/get-film/' + fid.value
  })
    .then(function (response) {
      if (response.data.code == '200') {
        filData.value = response.data.data
        star.value = filData.value.rating
      }
    })
    .catch(function (error) {
      console.log(error)
    })
}

const judgeFil = (value) => {
  let data = {
    fid: fid.value,
    star: value
  }
  axios({
    method: 'post',
    url: '/svr/api/films/judge-film',
    headers: {
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + token.value
    },
    data: data
  })
    .then(function (response) {
      if (response.data.code == '200') {
        ElMessage({
          message: '评价成功！',
          type: 'success',
          plain: true
        })
      }
    })
    .catch(function (error) {
      console.log(error)
      if (error.response.status == 401) {
        token.value = ''
        userStore.setToken('')
        ElMessage({
          message: '请重新登录！',
          type: 'success',
          plain: true
        })
      }
    })
}

const disDatas = ref([])

function initDis() {
  axios({
    method: 'get',
    url: '/svr/api/films/get-discuss/' + fid.value
  })
    .then(function (response) {
      if (response.data.code == '200') {
        disDatas.value = response.data.data
      }
    })
    .catch(function (error) {
      console.log(error)
    })
}

function pubDiscuss() {
  let data = {
    fid: fid.value,
    comment: comment.value
  }
  axios({
    method: 'post',
    url: '/svr/api/films/pub-discuss',
    headers: {
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + token.value
    },
    data: data
  })
    .then(function (response) {
      if (response.data.code == '200') {
        initDis()
        filData.value.commentscount++
        comment.value = ''
        ElMessage({
          message: '发表影评成功！',
          type: 'success',
          plain: true
        })
      }
    })
    .catch(function (error) {
      if (error.response.status == 401) {
        token.value = ''
        userStore.setToken('')
        ElMessage({
          message: '请重新登录！',
          type: 'success',
          plain: true
        })
      }
    })
}

function judgeDiscus(did, judge) {
  let data = {
    did: did,
    toplow: judge
  }
  axios({
    method: 'post',
    url: '/svr/api/films/judge-discuss',
    headers: {
      'Content-Type': 'application/json',
      Authorization: 'Bearer ' + token.value
    },
    data: data
  })
    .then(function (response) {
      if (response.data.code == '200') {
        initDis()
        ElMessage({
          message: '评价成功！',
          type: 'success',
          plain: true
        })
      }
    })
    .catch(function (error) {
      if (error.response.status == 401) {
        token.value = ''
        userStore.setToken('')
        ElMessage({
          message: '请重新登录！',
          type: 'success',
          plain: true
        })
      }
    })
}
</script>
