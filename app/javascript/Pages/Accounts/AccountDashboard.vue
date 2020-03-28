<template>
  <div class="flex justify-center">
    <div class="w-full bg-gray-900">
      <div class="flex rounded-lg shadow-xl overflow-hidden p-4 w-full flex-wrap">
        <h1 class="text-indigo-400 text-3xl w-full">Projects</h1>

        <div id="projects_list" class="w-full mt-8 flex flex-wrap sm:flex-row">
          <div class="md:w-1/4 pr-2 w-full md:mb-0 mb-6">
            <div class="border-2 border-dashed border-indigo-600 items-center justify-center flex px-4 py-8" style="min-height: 10rem;">
              <button @click="showNewProject" class="bg-transparent hover:bg-indigo-600 text-indigo-700 font-semibold hover:text-white py-2 px-4 border border-indigo-600 hover:border-transparent rounded text-sm">New Project</button>
            </div>
            <modal
              :open="creatingProject"
              title="Create Project"
              @close="creatingProject = false"
            >
              <new-project @success="modalNew = false" class="" />
            </modal>
          </div>
          <inertia-link :href="projectPath(project)" class="md:w-1/4 w-full pr-2 pb-4" v-for="project in projects">
            <project-card :project="project" />
          </inertia-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main'
import ProjectCard from '@/Components/ProjectCard'
import Modal from '@/Components/Modal'
import NewProject from '@/Pages/Projects/NewProject'

export default {
  metaInfo: { title: 'Account Dashboard' },
  layout: Layout,
  components: {
    ProjectCard,
    Modal,
    NewProject,
  },
  props: {
    projects: Array,
  },
  data() {
    return {
      allProjects: [],
      creatingProject: false,
    }
  },
  computed: {
  },
  methods: {
    showNewProject() {
      this.creatingProject = true
    },
    projectPath (project) {
      return this.$routes.project(project.id)
    },
  },
}
</script>
