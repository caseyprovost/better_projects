<template>
  <div :class="wrapperClasses">
    <div class="menu">
      <div class="flex justify-end mb-2">
        <a
          href="#"
          @click.prevent="$emit('close')"
          class="btn-circle-outline border-indigo-100 text-indigo-100 text-sm w-8 h-8 mt-2 mr-2"
        >
          <i class="fas fa-times"></i>
        </a>
      </div>
      <ul>
        <li>
          <inertia-link :href="editMessagePath" class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline">
            <i class="fas fa-edit text-sm mr-1"></i>
            <span>Edit</span>
          </inertia-link>
        </li>
        <li>
          <inertia-link :href="copyMessagePath" class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline">
            <i class="fas fa-copy text-sm mr-1"></i>
            <span>Copy</span>
          </inertia-link>
        </li>
        <li>
          <a href="#" class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline">
            <i class="fas fa-arrow-circle-right text-sm mr-1"></i>
            <span>Move</span>
          </a>
        </li>
        <li>
          <a href="#" class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline">
            <i class="fas fa-archive text-sm mr-1"></i>
            <span>Archive</span>
          </a>
        </li>
        <li>
          <a href="#" class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline">
            <i class="fas fa-bookmark text-sm mr-1"></i>
            <span>Bookmark</span>
          </a>
        </li>
        <li>
          <a href="#" class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline">
            <i class="fas fa-trash text-sm mr-1"></i>
            <span>Trash</span>
          </a>
        </li>
      </ul>
      <div>
        <h4 class="mt-3 mb-1 ml-2 text-indigo-100 font-semibold text-sm">Share</h4>
        <ul>
          <li>
            <a href="#" class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline">
              <i class="fas fa-link text-sm mr-1"></i>
              <span>Get a public link</span>
            </a>
          </li>
          <li>
            <a href="#" class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline">
              <i class="far fa-handshake text-sm mr-1"></i>
              <span>Share with someone</span>
            </a>
          </li>
        </ul>
      </div>
      <div>
        <h4 class="mt-3 mb-1 ml-2 text-indigo-100 font-semibold text-sm">History</h4>
        <ul>
          <li>
            <a href="#" class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline">
              <i class="far fa-clipboard text-sm mr-1"></i>
              <span>View the change log</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  import currentProject from '@/utils/currentProject'

  export default {
    mixins: [currentProject],
    props: {
      message: {
        type: Object,
        required: true
      },
      opened: {
        type: Boolean,
        required: false,
        default: false
      }
    },
    computed: {
      wrapperClasses() {
        let classes = `bg-indigo-600 py-1 absolute right-0 top-0 overflow-hidden h-auto`

        if (this.opened) {
          classes += " active"
        }

        return classes
      },
      editMessagePath() {
        return this.$routes.edit_project_message(this.project, this.message)
      },
      copyMessagePath() {
        return this.$routes.new_project_message_copy(this.project, this.message)
      }
    }
  }
</script>

<style scoped="true">
  .menu {
    width: 0px;
    overflow: hidden;
    transition: width 0.2s;
  }

  .active > .menu {
    @apply w-56;
    transition: width 0.2s;
  }
</style>
