<template>
  <div :class="wrapperClasses">
    <div class="menu">
      <div class="flex justify-end mb-2">
        <a
          href="#"
          class="btn-circle-outline border-indigo-100 text-indigo-100 text-sm w-8 h-8 mt-2 mr-2"
          @click.prevent="$emit('close')"
        >
          <i class="fas fa-times" />
        </a>
      </div>
      <ul>
        <li>
          <inertia-link
            :href="editMessagePath"
            class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline"
          >
            <i class="fas fa-edit text-sm mr-1" />
            <span>Edit</span>
          </inertia-link>
        </li>
        <li>
          <inertia-link
            :href="copyRecordingPath"
            class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline"
          >
            <i class="fas fa-copy text-sm mr-1" />
            <span>Copy</span>
          </inertia-link>
        </li>
        <li>
          <a
            :href="moveRecordingPath"
            class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline"
          >
            <i class="fas fa-arrow-circle-right text-sm mr-1" />
            <span>Move</span>
          </a>
        </li>
        <li>
          <a
            href="#"
            class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline"
          >
            <i class="fas fa-archive text-sm mr-1" />
            <span>Archive</span>
          </a>
        </li>
        <li>
          <a
            href="#"
            class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline"
          >
            <i class="fas fa-bookmark text-sm mr-1" />
            <span>Bookmark</span>
          </a>
        </li>
        <li>
          <a
            href="#"
            class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline"
          >
            <i class="fas fa-trash text-sm mr-1" />
            <span>Trash</span>
          </a>
        </li>
      </ul>
      <div>
        <h4 class="mt-3 mb-1 ml-2 text-indigo-100 font-semibold text-sm">
          Share
        </h4>
        <ul>
          <li>
            <a
              href="#"
              class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline"
            >
              <i class="fas fa-link text-sm mr-1" />
              <span>Get a public link</span>
            </a>
          </li>
          <li>
            <a
              href="#"
              class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline"
            >
              <i class="far fa-handshake text-sm mr-1" />
              <span>Share with someone</span>
            </a>
          </li>
        </ul>
      </div>
      <div>
        <h4 class="mt-3 mb-1 ml-2 text-indigo-100 font-semibold text-sm">
          History
        </h4>
        <ul>
          <li>
            <a
              href="#"
              class="text-indigo-100 py-2 px-6 hover:bg-pink-600 hover:text-pink-100 block items-center flex-inline"
            >
              <i class="far fa-clipboard text-sm mr-1" />
              <span>View the change log</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      message: {
        type: Object,
        required: true,
      },
      recording: {
        type: Object,
        required: true,
      },
      opened: {
        type: Boolean,
        required: false,
        default: false,
      },
    },
    computed: {
      wrapperClasses() {
        let classes = 'bg-indigo-600 py-1 absolute right-0 top-0 overflow-hidden h-auto'

        if (this.opened) {
          classes += ' active'
        }

        return classes
      },
      editMessagePath() {
        return this.$routes.edit_bucket_message(this.currentBucket, this.message)
      },
      copyRecordingPath() {
        return this.$routes.new_bucket_recording_copy(this.currentBucket, this.recording)
      },
      moveRecordingPath() {
        return this.$routes.new_bucket_recording_move(this.currentBucket, this.recording)
      },
      currentBucket() {
        return this.$page.current_bucket
      },
    },
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
