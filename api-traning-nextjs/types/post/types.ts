import { User } from "@/types/user/types"

export interface Post {
  id: string
  content: string
  user: User,
  likes_count: number,
  comments_count: number
}