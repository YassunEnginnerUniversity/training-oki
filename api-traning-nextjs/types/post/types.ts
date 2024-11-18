import { User } from "@/types/user/types"

export interface Post {
  id: string
  content: string
  user: User
  likes_count: number
  is_liked_by_current_user: boolean
  comments_count: number
}