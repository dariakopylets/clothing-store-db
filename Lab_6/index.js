const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
async function main() {
  console.log("--- Тестування Prisma Client ---");
  const newReview = await prisma.review.create({
    data: {
      rating: 5,
      comment: "Дуже якісний товар, розмір підійшов ідеально!",
      product_id: 1 
    }
  });
  console.log("Додано новий відгук:", newReview);
  const productWithReviews = await prisma.products.findUnique({
    where: { product_id: 1 },
    include: { reviews: true } 
  });

  console.log("\nТовар разом із відгуками:");
  console.dir(productWithReviews, { depth: null });
}
main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });