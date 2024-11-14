import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'

import App from './App.vue'
import router from './router'
// 引入 ElementPlus
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
// 引入 ElementPlus 的图标
import * as ElementPlusIconsVue from '@element-plus/icons-vue'

// 引入 axios 和 vue-axios
import axios from 'axios'
import VueAxios from 'vue-axios'

const app = createApp(App)

app.use(createPinia())
app.use(router)

//挂载 axios 和 vue-axios，然而只是这样全局并不能用
app.use(VueAxios, axios)
//将 axios 组件注入全局 axios, 这样才能全局使用
app.provide('axios', app.config.globalProperties.axios)

// 挂载 ElementPlus
app.use(ElementPlus)
// 注册 ElementPlus 的所有图标
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
  app.component(key, component)
}

app.mount('#app')
