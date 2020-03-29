<template>
  <div class="p-6 bg-indigo-900  min-h-screen flex justify-center items-center">
    <div class="w-full max-w-md">
      <logo
        class="block mx-auto w-full max-w-xs fill-white"
        height="50"
      />
      <form
        class="mt-8 bg-gray-900 rounded-lg shadow-xl overflow-hidden"
        @submit.prevent="submit"
      >
        <div class="px-10 py-12">
          <h1 class="text-center font-bold text-2xl text-gray-400">
            Reset Your Password
          </h1>
          <div class="mx-auto mt-6 w-24 border-b-2" />
          <text-input
            v-model="form.email"
            class="mt-10"
            label="Email"
            type="email"
            :errors="fieldErrors('email')"
            autofocus
            autocapitalize="off"
          />
        </div>
        <div class="px-10 py-4 bg-gray-900 border-t border-gray-800 flex justify-between items-center">
          <inertia-link
            class="hover:underline text-green-600"
            tabindex="-1"
            :href="loginPath"
          >Login</inertia-link>
          <loading-button
            :loading="sending"
            class="btn btn-indigo"
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
import LoadingButton from '@/Components/LoadingButton'
import Logo from '@/Components/Logo'
import TextInput from '@/Components/TextInput'
import formHelpers from '@/utils/formHelpers'

export default {
  metaInfo: { title: 'Login' },
  mixins: [formHelpers],
  layout: Layout,
  components: {
    LoadingButton,
    Logo,
    TextInput,
  },
  props: {
    resource_errors: Object
  },
  data() {
    return {
      sending: false,
      form: {
        email: null,
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
        .post(this.$routes.user_password(), {
          user: this.form,
        })
        .then(() => (this.sending = false))
    }
  }
}
</script>
