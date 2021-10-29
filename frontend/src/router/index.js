import Vue from 'vue'
import VueRouter from 'vue-router'

import Home from '../views/Home.vue'
import Register from '../views/Register.vue'
import UserView from '../views/UserView.vue'
import WorkingTimesView from '../views/WorkingTimesView.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  },
  {
    path: '/user/:userId',
    name: 'UserView',
    component: UserView
  },
  {
    path: '/workingTimes/:userId',
    name: 'WorkingTimeView',
    component: WorkingTimesView
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
