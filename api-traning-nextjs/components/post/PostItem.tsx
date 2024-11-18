"use client"

import { Card, CardContent, CardFooter, CardHeader } from '@/components/ui/card'
import Link from 'next/link'
import { Button } from "@/components/ui/button"
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar"
import { Heart, MessageCircle, Repeat2 } from 'lucide-react'
import { Post } from '@/types/post/types'
import { useState } from 'react'
import { updateLike } from '@/actions/like/updateLike'

interface PostItemProps {
  post: Post
}

const PostItem = ({post}: PostItemProps) => {
  const [postState, setPostState] = useState(post);

  const handleUpdateLike = updateLike.bind(null,post.id.toString()) // server actionsに引数を渡すためにbindを使用
  const updateLikesCount = async () => {
    const newLikesCount = await handleUpdateLike();
    setPostState((prevState) => ({
      ...prevState,
      likes_count: newLikesCount.likes_count
    }));
  };

  return (
    <Card>
      <CardHeader>
        <div className="flex items-center space-x-4">
          <Avatar>
            <AvatarImage src="https://github.com/shadcn.png" alt="@shadcn" />
            <AvatarFallback>CN</AvatarFallback>
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
          <form action={updateLikesCount}>
            <Button type="submit" variant="ghost" size="sm">
              <Heart className="w-4 h-4 mr-2" />
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