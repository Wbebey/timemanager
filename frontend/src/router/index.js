import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  { path: '/', component: () => import("../views/Home.vue") },
  { path: '/about', component: () => import("../views/About.vue") },
  { path: '/register', component: () => import("../views/Register.vue") },
  { path: '/user/:userId', component: () => import("../views/UserView.vue") },
  { path: '/workingTimes', component: () => import("../views/WorkingTimesView.vue") },
  { path: '/:pathMatch(.*)*', component: () => import("../views/PathNotFound.vue") },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
