// Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

import type { RouteRecordRaw } from 'vue-router'

export const isMainRoute = true

const route: RouteRecordRaw = {
  path: '/login',
  name: 'Login',
  component: () => import('./views/Login.vue'),
  meta: {
    title: __('Sign in'),
    requiresAuth: false,
    requiredPermission: null,
  },
}

export default route
