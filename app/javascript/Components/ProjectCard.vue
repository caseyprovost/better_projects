<template>
  <div class="bg-indigo-600 p-4 flex flex-col justify-between rounded" style="min-height: 10rem;">
    <h3 class="text-xl text-indigo-100">{{ project.name }}</h3>
    <p class="text-indigo-200 leading-tight">
      {{ project.description }}
    </p>
    <span class="text-indigo-200">{{ membersString }}</span>
  </div>
</template>

<script>
import Layout from '@/Layouts/Main'
import ProjectCard from '@/Components/ProjectCard'

export default {
  components: {
    ProjectCard,
  },
  props: {
    project: Object,
  },
  data() {
    return {
    }
  },
  computed: {
    membersString() {
      if (this.memberCount == 1) {
        return `1 member`
      } else {
        return `${this.memberCount} members`
      }
    },
    memberCount() {
      return this.project.memberships.length
    }
  },
  methods: {
  },
}
</script>
