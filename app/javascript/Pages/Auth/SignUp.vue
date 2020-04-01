<template>
  <div class="p-6 bg-indigo-900 min-h-screen flex justify-center items-center">
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
          <h1 class="text-center font-bold text-2xl text-gray-400 ">
            Let's Get It Started
          </h1>
          <div class="mx-auto mt-6 w-24 border-b-2 bg-gray-400" />
          <text-input
            id="user_name"
            v-model="form.name"
            class=""
            label="Name"
            type="name"
            :errors="fieldErrors('name')"
            autofocus
            autocapitalize="off"
          />
          <text-input
            id="user_email"
            v-model="form.email"
            class=""
            label="Email"
            type="email"
            :errors="fieldErrors('email')"
            autofocus
            autocapitalize="off"
          />
          <text-input
            id="user_password"
            v-model="form.password"
            class=""
            label="Password"
            type="password"
            :errors="fieldErrors('password')"
          />
          <text-input
            id="user_password_confirmation"
            v-model="form.password_confirmation"
            class=""
            label="Confrim password"
            type="password"
            :errors="fieldErrors('password_confirmation')"
          />
        </div>
        <div class="px-10 py-4 bg-gray-900 border-t border-gray-800 flex justify-between items-center">
          <inertia-link
            class="hover:underline text-green-600"
            tabindex="-1"
            :href="loginPath"
          >
            Login
          </inertia-link>
          <loading-button
            :loading="sending"
            class="btn btn-indigo"
            type="submit"
          >
            Sign Up!
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
  metaInfo: { title: 'Sign Up' },
  components: {
    LoadingButton,
    Logo,
    TextInput,
  },
  mixins: [formHelpers],
  layout: Layout,
  data() {
    return {
      sending: false,
      form: {
        name: null,
        email: null,
        password: null,
        password_confirmation: null,
      },
    }
  },
  computed: {
    loginPath () {
      return this.$routes.new_user_session()
    },
  },
  methods: {
    submit() {
      this.sending = true
      this.$inertia
        .post(this.$routes.user_registration(), {
          user: this.form,
        })
        .then(() => (this.sending = false))
    },
  },
}
</script>
