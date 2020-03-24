<template>
  <div class="flex justify-center">
    <div class="w-full bg-gray-900">
      <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-wrap">
        <h1 class="text-indigo-400 text-3xl w-full">Projects</h1>

        <div id="projects_list" class="w-full mt-8 flex flex-wrap">
          <div class="md:w-1/4 mr-2">
            <div class="border-2 border-dashed border-indigo-600 items-center justify-center flex px-4 py-8" style="min-height: 10rem;">
              <inertia-link href="#" class="bg-transparent hover:bg-indigo-600 text-indigo-700 font-semibold hover:text-white py-2 px-4 border border-indigo-600 hover:border-transparent rounded text-sm">New Project</inertia-link>
            </div>
          </div>
          <div class="md:w-1/4">
            <div class="bg-indigo-600 p-2 flex flex-col justify-between" style="min-height: 10rem;">
              <h3 class="text-xl text-indigo-100">Project Name</h3>
              <p class="text-indigo-200">
                A really cool and long description about how awesome this project is and all the things that it involves...
              </p>
              <span class="text-indigo-200">23 members</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main'

export default {
  metaInfo: { title: 'Account Dashboard' },
  layout: Layout,
  components: {
    // LoadingButton,
    // Logo,
    // TextInput,
  },
  props: {
    projects: Array,
  },
  data() {
    return {
      allProjects: [],
    }
  },
  computed: {
  },
  methods: {
  },
}
</script>
