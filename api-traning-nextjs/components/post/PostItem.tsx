import React from 'react'
import { Card, CardContent, CardFooter, CardHeader } from '@/components/ui/card'
import Link from 'next/link'
import { Button } from "@/components/ui/button"
import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar"
import { MessageCircle } from 'lucide-react'
import LikeButton from '@/components/post/LikeButton'

const PostItem = () => {
  return (
    <Card>
      <CardHeader>
        <div className="flex items-center space-x-4">
          <Avatar>
            <AvatarImage src="https://github.com/shadcn.png" alt="@shadcn" />
            <AvatarFallback>CN</AvatarFallback>
          </Avatar>
          <div>
            <Link href={`/user/1`} className="font-semibold hover:underline">
              testuser
            </Link>
            <p className="text-sm text-gray-500">@testuser</p>
          </div>
        </div>
      </CardHeader>
      <CardContent>
        <p>投稿内容投稿内容投稿内容投稿内容投稿内容投稿内容</p>
      </CardContent>
      <CardFooter>
        <div className="flex space-x-4 text-gray-500">
          <LikeButton likesCount={"1"} />
          <Button variant="ghost" size="sm">
              <MessageCircle className="w-4 h-4 mr-2" />
              0
              </Button>
          <Button variant="ghost" size="sm">
          </Button>
        </div>
      </CardFooter>
    </Card>
  )
}

export default PostItem