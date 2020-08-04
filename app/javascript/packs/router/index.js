import Vue from "vue";
import Router from "vue-router";

const routerOptions = [
  { path: "/", component: "landing" },
  { path: "/books", component: "books"},
  { path: "/tasks", component: "tasks"},
  { path: "/signin", component: "SignIn" },
  { path: "/signup", component: "SignUp" },
  { path: "/home", component: "Home", meta: { requiresAuth: true } },
  { path: "*", component: "NotFound" }
];

const routes = routerOptions.map(route => {
  return {
    ...route,
    component: () => import(`../components/${route.component}.vue`)
  };
});

Vue.use(Router);

export default new Router({
  mode: "history",
  routes
});
