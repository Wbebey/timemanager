import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../components/Home.vue'
import WorkingTimes from '../components/WorkingTimes.vue'
import WorkingTime from '../components/WorkingTime.vue'
import ClockManager from '../components/ClockManager.vue'
import ChartManager from '../components/ChartManager.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/workingTimes/:userId',
    name: 'WorkingTimes',
    component: WorkingTimes
  },
  {
    path: '/workingTime/:userId',
    name: 'WorkingTime',
    component: WorkingTime
  },
  {
    path: '/workingTime/:userId/:workingtimeId',
    name: 'WorkingTime',
    component: WorkingTime
  },
  {
    path: '/clock/:username',
    name: 'ClockManager',
    component: ClockManager
  },
  {
    path: '/chartManager/:userid',
    name: 'ChartManager',
    component: ChartManager
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
