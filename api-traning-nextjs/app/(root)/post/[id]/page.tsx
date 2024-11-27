import { getPost } from "@/actions/post/getPost"
import CommentList from "@/components/comment/CommentList"
import PostDetail from "@/components/post/PostDetail"


const PostDetailPage = async ({params}:{params: Promise<{ id: string }>}) => {
  const postId = (await params).id
  const post = await getPost(postId)
  return (
    <div className="max-w-[850px] mx-auto p-4 w-full">
      <PostDetail post={post}/>
      <h3 className="text-xl font-bold mb-4">コメント</h3>
      <CommentList comments={post.comments}/>
    </div>
  )
}

export default PostDetailPage