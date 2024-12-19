'use client';

import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
} from '@/components/ui/card';
import Link from 'next/link';
import { Button } from '@/components/ui/button';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Heart, MessageCircle } from 'lucide-react';
import { Post } from '@/types/post/types';
import { useState } from 'react';
import { updateLike } from '@/actions/like/updateLike';
import { deleteLike } from '@/actions/like/deleteLike';
import { useRouter } from 'next/navigation';
import { generatePokemonIcon } from '@/utils/generatePokemonIcon';

interface PostItemProps {
  post: Post;
}

const PostItem = ({ post }: PostItemProps) => {
  const [postState, setPostState] = useState(post);
  const router = useRouter();

  const handleCardClick = () => {
    router.push(`/post/${postState.id}`);
  };

  const handleUpdateLike = updateLike.bind(null, String(post.id)); // server actionsに引数を渡すためにbindを使用
  const handleDeleteLike = deleteLike.bind(null, String(post.id));

  const handleLike = async () => {
    if (postState.is_liked_by_current_user) {
      const newLikesCount = await handleDeleteLike();
      setPostState((prevState) => ({
        ...prevState,
        likes_count: newLikesCount.likes_count,
        is_liked_by_current_user: false,
      }));
    } else {
      const newLikesCount = await handleUpdateLike();
      setPostState((prevState) => ({
        ...prevState,
        likes_count: newLikesCount.likes_count,
        is_liked_by_current_user: true,
      }));
    }
  };

  return (
    <Card
      onClick={handleCardClick}
      className="cursor-pointer hover:shadow-md transition-all duration-200 dark:bg-gray-950 dark:border-gray-800"
    >
      <CardHeader className="space-y-3">
        <div className="flex items-center space-x-4">
          <Avatar className="border-2 border-gray-100 dark:border-gray-800">
            <AvatarImage
              src={`/pokemon/${generatePokemonIcon(post.user.username)}.png`}
              alt={post.user.username}
            />
            <AvatarFallback className="bg-gray-100 dark:bg-gray-800">
              {post.user.username}
            </AvatarFallback>
          </Avatar>
          <div
            onClick={(e) => e.stopPropagation()}
            className="flex flex-col space-y-1"
          >
            <Link
              href={`/user/${postState.user.id}`}
              className="font-semibold text-gray-900 dark:text-gray-100 hover:underline transition-colors"
            >
              {postState.user.username}
            </Link>
            <p className="text-sm text-gray-500 dark:text-gray-400">
              @{postState.user.username}
            </p>
          </div>
        </div>
      </CardHeader>
      <CardContent className="pb-4">
        <p className="leading-7 text-gray-800 dark:text-gray-200">
          {postState.content}
        </p>
      </CardContent>
      <CardFooter className="border-t dark:border-gray-800 pt-4">
        <div className="flex space-x-6 text-gray-500 dark:text-gray-400">
          <form action={handleLike} onClick={(e) => e.stopPropagation()}>
            <Button
              type="submit"
              variant="ghost"
              size="sm"
              className="hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
            >
              {postState.is_liked_by_current_user ? (
                <Heart
                  color="red"
                  fill="red"
                  stroke="none"
                  className="w-4 h-4 mr-2"
                />
              ) : (
                <Heart className="w-4 h-4 mr-2" />
              )}
              <span className="font-medium">{postState.likes_count}</span>
            </Button>
          </form>
          <Button
            variant="ghost"
            size="sm"
            className="hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
          >
            <MessageCircle className="w-4 h-4 mr-2" />
            <span className="font-medium">{postState.comments_count}</span>
          </Button>
        </div>
      </CardFooter>
    </Card>
  );
};

export default PostItem;
