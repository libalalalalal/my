import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue'
import RegisterView from '@/views/RegisterView.vue'
import LoginView from '@/views/LoginView.vue'
import SeachView from '@/views/SeachView.vue'
import OutView from '@/views/OutView.vue'
import FilmListView from '@/views/FilmListView.vue'
import FilmView from '@/views/FilmView.vue'
import UserView from '@/views/UserView.vue'
import MyDiscussView from '@/views/MyDiscussView.vue'
import MyPwdView from '@/views/MyPwdView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/register',
      name: 'register',
      component: RegisterView
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView
    },
    {
      path: '/seach/:keyword',
      name: 'seach',
      component: SeachView
    },
    {
      path: '/out',
      name: 'out',
      component: OutView
    },
    {
      path: '/fillist/:tid',
      name: 'fillist',
      component: FilmListView
    },
    {
      path: '/fil/:fid/:tid',
      name: 'fil',
      component: FilmView
    },
    {
      path: '/user',
      name: 'user',
      component: UserView
    },
    {
      path: '/mydis',
      name: 'mydis',
      component: MyDiscussView
    },
    {
      path: '/mypwd',
      name: 'mypwd',
      component: MyPwdView
    }
  ]
})

export default router
