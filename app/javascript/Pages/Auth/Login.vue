<template>
  <div class="p-6 bg-indigo-900  min-h-screen flex justify-center items-center">
    <div class="w-full max-w-md">
      <logo
        class="block mx-auto w-full max-w-xs fill-white"
        height="50"
      />
      <form
        class="mt-8 bg-gray-900  rounded-lg shadow-xl overflow-hidden"
        @submit.prevent="submit"
      >
        <div class="px-10 py-12">
          <h1 class="text-center font-bold text-2xl text-gray-400">
            Sign In
          </h1>
          <div class="mx-auto mt-6 w-24 border-b-2 border-gray-400" />
          <text-input
            id="user_email"
            v-model="form.email"
            class="mt-10"
            label="Email"
            type="email"
            name="user[email]"
            autofocus
            autocapitalize="off"
          />
          <text-input
            id="user_password"
            v-model="form.password"
            class="mt-6"
            label="Password"
            type="password"
            name="user[password]"
          />
          <div class="flex justify-between mt-6">
            <div class="">
              <label
                class="select-none flex items-center"
                for="remember"
              >
                <input
                  id="remember"
                  v-model="form.remember_me"
                  class="mr-1 border border-indigo-700"
                  type="checkbox"
                  name="user[remember_me]"
                >
                <span class="text-sm text-gray-400">Remember Me</span>
              </label>
            </div>
            <div class="text-sm items-center">
              <span class="mr-1 text-gray-400">
                Need an account?
              </span>
              <inertia-link
                class="hover:underline"
                tabindex="-1"
                :href="signUpPath"
              >
                Sign Up!
              </inertia-link>
            </div>
          </div>
        </div>
        <div class="px-10 py-4 bg-gray-900 border-t border-gray-800 flex justify-between items-center">
          <inertia-link
            class="hover:underline text-sm"
            tabindex="-1"
            :href="resetPasswordPath"
          >
            Forget your password?
          </inertia-link>
          <loading-button
            :loading="sending"
            class="btn btn-indigo"
            type="submit"
          >
            Sign in
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Minimal'
import LoadingButton from '@/Components/LoadingButton'
import Logo from '@/Components/Logo'
import TextInput from '@/Components/TextInput'
export default {
  metaInfo: { title: 'Login' },
  layout: Layout,
  components: {
    LoadingButton,
    Logo,
    TextInput,
  },
  data() {
    return {
      sending: false,
      form: {
        email: null,
        password: null,
        remember_me: null,
      },
    }
  },
  computed: {
    resetPasswordPath () {
      return this.$routes.new_user_password()
    },
    signUpPath()  {
      return this.$routes.new_user_registration()
    },
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia
        .post(this.$routes.user_session(), {
          user: this.form,
        })
        .then(() => (this.sending = false))
    },
  },
}
</script>
