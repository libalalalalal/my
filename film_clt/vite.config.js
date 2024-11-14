import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  server: {
    proxy: {
      '/svr': {
        // 代理接口地址。实际请求接口地址可能是：http://127.0.0.1:5000/api/xxx/xxx
        target: 'http://127.0.0.1:5000',
        // 默认 false，是否需要改变原始主机头为目标 URL
        changeOrigin: true,
        // 重写请求。实际接口中并没有 /svr，所以需要替换为空 ''
        rewrite: (path) => path.replace(/^\/svr/, '')
      }
    }
  },
  plugins: [vue()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  }
})
