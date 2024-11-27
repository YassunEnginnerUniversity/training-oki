"use client"

import { TabsList, TabsTrigger } from "@/components/ui/tabs";
import { useRouter } from "next/navigation";

const TabPostList = () => {
  const router = useRouter();

  const handleTabClick = (type:string) => {
    switch (type) {
      case "all":
        router.push("/")
        break;
      case "mine":
        router.push("/?tab=mine")
        break;
      case "following":
        router.push("/?tab=following")
        break;
      default:
        break;
    }
  }
  return (
    <TabsList>
      <TabsTrigger value="all" onClick={() => handleTabClick("all")}>All Posts</TabsTrigger>
      <TabsTrigger value="mine" onClick={() => handleTabClick("mine")}>My Posts</TabsTrigger>
      <TabsTrigger value="following" onClick={() => handleTabClick("following")}>Following</TabsTrigger>
    </TabsList>
  )
}

export default TabPostList