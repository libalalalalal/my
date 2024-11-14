import { ref } from 'vue'
import { defineStore } from 'pinia'
export const useTokenStore = defineStore('token', () => {
  // 定义 Token
  const token = ref('')
  // 设置 Token
  function setToken(token) {
    this.token = token
    // 将 Token 存储至本地存储
    localStorage.setItem('token', this.token)
  }
  // 获取 Token
  function getToken() {
    // 从本地存储获取 Token
    this.token = localStorage.getItem('token')
    return this.token
  }
  // 曝露变量及方法
  return { token, setToken, getToken }
})
