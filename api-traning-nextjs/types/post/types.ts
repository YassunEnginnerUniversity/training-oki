import { User } from '@/types/user/types';

export interface Post {
  id: string;
  content: string;
  user: User;
  likes_count: number;
  is_liked_by_current_user: boolean;
  comments_count: number;
}

export interface PostDetailType {
  id: string;
  content: string;
  created_at: string;
  updated_at: string;
  user: User;
  likes_count: number;
  is_liked_by_current_user: boolean;
  comments: Comment[];
}

export interface Pagenation {
  current_page: number;
  total_pages: number;
  total_count: number;
}

export interface PostsResponse {
  posts: Post[];
  pagenation: Pagenation;
}

export interface CommentType {
  id: string;
  content: string;
  created_at: string;
  updated_at: string;
  user: User;
}

export interface CreatePost {
  error: string;
}
