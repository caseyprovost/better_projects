<template>
  <minimal-layout>
    <div class="flex flex-col">
      <div
        class="h-screen flex flex-col"
        @click="hideDropdownMenus"
      >
        <div class="md:flex flex-shrink-0">
          <div class="bg-indigo-700 md:flex-shrink-0 px-6 py-4 flex items-center justify-between md:justify-center border-b border-indigo-500">
            <inertia-link
              :href="$routes.root()"
              aria-label="Home"
              role="navigation"
            >
              <h1 class="text-2xl text-indigo-100">Better Projects</h1>
            </inertia-link>
            <dropdown
              class="md:hidden"
              placement="bottom-end"
              aria-label="Main menu"
            >
              <svg
                class="fill-white w-6 h-6"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
              ><path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z" /></svg>
              <div
                slot="dropdown"
                class="mt-2 px-8 py-4 shadow-lg bg-indigo-800 rounded"
              >
                <main-menu :url="url()" />
              </div>
            </dropdown>
          </div>
          <div class="bg-indigo-600 border-b w-full p-4 md:py-0 md:px-12 text-sm text-indigo-100 md:text-md flex justify-end items-center border-indigo-500">
            <dropdown
              class="mt-1"
              placement="bottom-end"
              aria-label="User menu"
            >
              <div class="flex items-center cursor-pointer select-none group">
                <div class="text-indigo-100 group-hover:text-indigo-600 focus:text-indigo-600 mr-1 whitespace-no-wrap">
                  <span>{{ $page.auth.user.name }}</span>
                </div>
                <icon
                  class="w-5 h-5 group-hover:fill-indigo-600 fill-indigo-100 focus:fill-indigo-300"
                  name="cheveron-down"
                />
              </div>
              <div
                slot="dropdown"
                class="mt-2 py-2 shadow-xl bg-white rounded text-sm"
              >
                <inertia-link
                  class="block px-6 py-2 hover:bg-indigo-600 hover:text-white"
                  role="navigation"
                  :href="$routes.edit_user_registration($page.auth.user.id)"
                >
                  My Profile
                </inertia-link>
                <inertia-link
                  class="block px-6 py-2 hover:bg-indigo-600 hover:text-white"
                  role="navigation"
                  :href="$routes.account_memberships($page.auth.account.id)"
                >
                  Manage Users
                </inertia-link>
                <inertia-link
                  class="block px-6 py-2 hover:bg-indigo-600 hover:text-white"
                  :href="$routes.destroy_user_session()"
                  method="delete"
                >
                  Logout
                </inertia-link>
              </div>
            </dropdown>
          </div>
        </div>
        <div v-if="$page.auth.account" class="bg-gray-800 py-2 px-4 text-gray-100 md:justify-end flex border-b border-gray-700">
          <div class="justify-between md:justify-end flex items-center sm:w-full">
            <p class="text-sm mr-2">Current Account: </p>
            <select-input v-model="$page.auth.account.id" class="text-sm">
              <option value="">Choose an account</option>
              <option :value="account.id" v-for="account in $page.auth.user.accounts">{{ account.name }}</option>
            </select-input>
          </div>
        </div>
        <div class="flex flex-grow overflow-hidden">
          <div
            class="flex-1 px-4 py-4 md:p-4 overflow-y-auto bg-gray-800"
            scroll-region
          >
            <slot />
          </div>
        </div>
      </div>
    </div>
  </minimal-layout>
</template>

<script>
import MinimalLayout from '@/Layouts/Minimal'
import Dropdown from '@/Components/Dropdown'
import Icon from '@/Components/Icon'
import Logo from '@/Components/Logo'
import SelectInput from '@/Components/SelectInput'
export default {
  components: {
    MinimalLayout,
    Dropdown,
    Icon,
    Logo,
    SelectInput,
  },
  data() {
    return {
      showUserMenu: false,
      accounts: null,
    }
  },
  methods: {
    url() {
      return location.pathname.substr(1)
    },
    hideDropdownMenus() {
      this.showUserMenu = false
    },
  },
}
</script>
