<template>
  <div class="p-6 bg-indigo-800 min-h-screen flex justify-center items-center">
    <div class="w-full max-w-md">
      <logo
        class="block mx-auto w-full max-w-xs fill-white"
        height="50"
      />
      <form
        class="mt-8 bg-white rounded-lg shadow-xl overflow-hidden"
        @submit.prevent="submit"
      >
        <div class="px-10 py-12">
          <h1 class="text-center font-bold text-2xl">
            Reset Your Password
          </h1>
          <div class="mx-auto mt-6 w-24 border-b-2" />
          <text-input
            v-model="form.email"
            class="mt-10"
            label="Email"
            type="email"
            autofocus
            autocapitalize="off"
          />
        </div>
        <div class="px-10 py-4 bg-gray-100 border-t border-gray-200 flex justify-between items-center">
          <a
            class="hover:underline"
            tabindex="-1"
            :href="loginPath"
          >Login</a>
          <loading-button
            :loading="sending"
            class="btn-indigo"
            type="submit"
          >
            Reset Password
          </loading-button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Minimal'
import LoadingButton from '@/Shared/LoadingButton'
import Logo from '@/Shared/Logo'
import TextInput from '@/Shared/TextInput'
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
        email: 'johndoe@example.com',
        password: 'secret',
        remember_me: null,
      },
    }
  },
  computed: {
    loginPath() {
      return this.$routes.new_user_session()
    },
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia
        .post(this.$routes.password(), {
          user: this.form,
        })
        .then(() => (this.sending = false))
    },
  },
}
</script>
