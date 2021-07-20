import 'core-js/stable'
import 'regenerator-runtime/runtime'
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('channels')

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import '../src/application.scss'
import 'vue-multiselect/dist/vue-multiselect.min.css'

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// require.context('../images', true)
// const imagePath = (name) => images(name, true)

import Vue from 'vue'
import VueMeta from 'vue-meta'
Vue.use(VueMeta)

import PortalVue from 'portal-vue'
Vue.use(PortalVue)

import VCalendar from 'v-calendar';
Vue.use(VCalendar, {
  componentPrefix: 'vc',
});

import 'vue-trix'
import axios from 'axios'

import moment from 'moment'
window.moment = moment

import '@fortawesome/fontawesome-free/js/fontawesome'
import '@fortawesome/fontawesome-free/js/solid'
import '@fortawesome/fontawesome-free/js/regular'
import '@fortawesome/fontawesome-free/js/brands'

require('trix')
require('@rails/actiontext')

// Tell Axios to send the CSRF token (taken from the cookie)
// in the header named as "X-CSRF-Token", as this is the name
// expected by Rails
axios.defaults.xsrfHeaderName = 'X-CSRF-Token'

import showFlash from '@/utils/flash'

import { InertiaApp } from '@inertiajs/inertia-vue'
Vue.use(InertiaApp)

import Routes from '@/utils/routes.js'
Vue.prototype.$routes = Routes

const app = document.getElementById('app')

new Vue({
  metaInfo: {
    titleTemplate: (title) => title ? `${title} - Better Projects` : 'Better Projects',
  },
  render: h => h(InertiaApp, {
    props: {
      initialPage: JSON.parse(app.dataset.page),
      resolveComponent: name => import(`@/Pages/${name}`).then(module => module.default),
      transformProps: props => {
        Vue.nextTick(() => {
          showFlash(props)
        })

        return props
      },
    },
  }),
}).$mount(app)
