@IsTest
private class AdderTest {

    @IsTest
    static void testAddNumbers() {
        Integer result = Adder.addNumbers(5, 10);
        System.assertEquals(15, result, '5 + 10 should equal 15');

        Integer result2 = Adder.addNumbers(-3, 7);
        System.assertEquals(4, result2, '-3 + 7 should equal 4');
    }
}