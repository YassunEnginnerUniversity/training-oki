"use client"

import { Card, CardContent, CardFooter, CardHeader } from '@/components/ui/card'
import Link from 'next/link'
import { Button } from "@/components/ui/button"
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar"
import { Heart, MessageCircle } from 'lucide-react'
import { Post } from '@/types/post/types'
import { useState } from 'react'
import { updateLike } from '@/actions/like/updateLike'
import { deleteLike } from '@/actions/like/deleteLike'
import { useRouter } from 'next/navigation'

interface PostItemProps {
  post: Post
}

const PostItem = ({post}: PostItemProps) => {
  const [postState, setPostState] = useState(post);
  const router = useRouter();

  const handleCardClick = () => {
    router.push(`/post/${postState.id}`);
  };


  const handleUpdateLike = updateLike.bind(null,String(post.id)) // server actionsに引数を渡すためにbindを使用
  const handleDeleteLike = deleteLike.bind(null, String(post.id))

  const handleLike = async () => {
    if(postState.is_liked_by_current_user) {
      const newLikesCount = await handleDeleteLike();
      setPostState((prevState) => ({
        ...prevState,
        likes_count: newLikesCount.likes_count,
        is_liked_by_current_user: false
      }));
    } else {
      const newLikesCount = await handleUpdateLike();
      setPostState((prevState) => ({
        ...prevState,
        likes_count: newLikesCount.likes_count,
        is_liked_by_current_user: true
      }));
    }
  }

  return (
    <Card onClick={handleCardClick} className="cursor-pointer">
      <CardHeader>
        <div className="flex items-center space-x-4">
          <Avatar>
            <AvatarImage src="https://github.com/shadcn.png" alt={postState.user.username} />
            <AvatarFallback>{postState.user.username}</AvatarFallback>
          </Avatar>
          <div>
            <Link href={`/user/${postState.user.id}`} className="font-semibold hover:underline">
              { postState.user.username }
            </Link>
            <p className="text-sm text-gray-500">@{postState.user.username}</p>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        <p className="leading-7">{postState.content}</p>
      </CardContent>
      <CardFooter>
        <div className="flex space-x-4 text-gray-500">
          <form action={handleLike}>
            <Button type="submit" variant="ghost" size="sm">
              {postState.is_liked_by_current_user? (
                <Heart color="red" fill="red" stroke="none" className="w-4 h-4 mr-2" />
              ):(
                <Heart className="w-4 h-4 mr-2" />
              )}
              { postState.likes_count }
            </Button>
          </form>
          <Button variant="ghost" size="sm">
            <MessageCircle className="w-4 h-4 mr-2" />
            {postState.comments_count}
            </Button>
          <Button variant="ghost" size="sm">
          </Button>
        </div>
      </CardFooter>
    </Card>
  )
}

export default PostItem