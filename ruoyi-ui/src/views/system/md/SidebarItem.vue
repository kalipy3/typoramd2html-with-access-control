<template>
  <div v-if="data">
    <template v-if="hasOneShowingChild(data.children,data) && (!onlyOneChild.children||onlyOneChild.noShowingChildren)&&!data.alwaysShow">
      <app-link v-if="onlyOneChild" :to="onlyOneChild.id">
        <el-menu-item :index="onlyOneChild.id"  :class="{'submenu-title-noDropdown':!isNest}">
          <item :title="onlyOneChild.no + ' ' + ' ' +  onlyOneChild.label" />
        </el-menu-item>
      </app-link>
    </template>

    <el-submenu v-else ref="subMenu" :index="onlyOneChild.id" popper-append-to-body>
      <template slot="title">
        <item v-if="data" :title="data.no + ' ' + data.label" />
      </template>
      <sidebar-item
        v-for="child in data.children"
        :key="child.id"
        :is-nest="true"
        :data="child"
        :base-path="child.id"
        class="nest-menu"
      />
    </el-submenu>
  </div >

    <!--
  <div>
    <ul>
        <li v-for="item in data">
<el-button type="text">
            <span>
            {{item.no}}
            {{item.label}}
            </span>
</el-button>
            <sidebar-item v-if="item.children" :data="item.children">
            </sidebar-item>
        </li>
    </ul>
  </div>
    -->
</template>

<script>
import path from 'path'
import { isExternal } from '@/utils/validate'
import Item from "../../../../src/layout/components/Sidebar/Item.vue"
import FixiOSBug from "../../../../src/layout/components/Sidebar/FixiOSBug"
import AppLink from "../../../../src/layout/components/Sidebar/Link.vue"

export default {
  name: 'SidebarItem',
  components: { Item, AppLink},
  mixins: [FixiOSBug],
  props: {
    // route object
    data: {
      type: Array,
      required: true,
        default() {
            return []
        }
    },
    isNest: {
      type: Boolean,
      default: false
    },
    basePath: {
      type: Number,
      default: 0
    }
  },
  data() {
    this.onlyOneChild = null
    return {}
  },
  methods: {
    hasOneShowingChild(children = [], parent) {

      if (!children) {
        children = [];
      }
      const showingChildren = children.filter(item => {
          // Temp set(will be used if only has one showing child)
          this.onlyOneChild = item
          return true
      })

      // When there is only one child router, the child router is displayed by default
      if (showingChildren.length === 1) {
        return true
      }

      // Show parent if there are no child router to display
      if (showingChildren.length === 0) {
        this.onlyOneChild = { ... parent, path: 0, noShowingChildren: true }
        return true
      }

      return false
    },
    resolvePath(routePath, routeQuery) {
      if (isExternal(routePath)) {
        return routePath
      }
      if (isExternal(this.basePath)) {
        return this.basePath
      }
      if (routeQuery) {
        let query = JSON.parse(routeQuery);
        return { path: path.resolve(this.basePath, routePath), query: query }
      }
      return path.resolve(this.basePath, routePath)
    }
  }
}
</script>
