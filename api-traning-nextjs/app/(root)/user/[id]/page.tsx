export default async function UserDetailPage({
  params,
}: {
  params: Promise<{ id: string }>
}) {
  const slug = (await params).id
  return <div>User ID: {slug}</div>
}