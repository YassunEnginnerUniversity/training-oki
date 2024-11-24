"use client"

import { getMyFollowingPosts } from "@/actions/post/getMyFollowingPosts"
import { getMyPosts } from "@/actions/post/getMyPosts"
import { getPostsAll } from "@/actions/post/getPostsAll"
import PostItem from "@/components/post/PostItem"
import { Post, PostsResponse } from "@/types/post/types"

export const loadMorePosts = async (page: number, type:string, userId: number) => {
  const cookies = document.cookie;
  let response:PostsResponse = {posts: [], pagenation: { current_page: 0, total_pages: 0,total_count: 0 }}
  
  switch (type) {
    case "all":
      response = await getPostsAll(page,cookies)
      break;
    case "mine":
      response = await getMyPosts(userId, page,cookies)
      break;
    case "following":
      response = await getMyFollowingPosts(userId, page,cookies)
      break;
    default:
      break;
  }

  const postsAll:Post[] = response.posts // 現在のページの投稿を10件を取得
  const currentPage:number | null = response.pagenation.current_page  // 現在のページ数を取得
  const totalPage:number | null = response.pagenation.total_pages  // トータルのページ数を取得
  
  // 値をリテラル型にし、読み取り専用にする
  return [
    postsAll.map((post: Post) => <PostItem key={post.id} post={post}/>),
    currentPage,
    totalPage
  ] as const 
}