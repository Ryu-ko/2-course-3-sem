import { fireEvent, render, screen } from '@testing-library/react';
import Counter2 from './Counter2.jsx';



describe(Counter2, () => {
    test("counter displays correct initial count", () => {
        const { getByTestId } = render(<Counter2 count={1} />); // getByTestId нужен для нахождения элемента по тестовому id (он нужен для динамических элементов, которые мы не можем взять просто так)
                                                                      // render(...) используется для теста определенного компонента
        const countValue = Number(getByTestId("count").textContent);  // создаем переменную, которую преобразум в int (с пом. Number), и записываем туда внутренний контент тега с тестовым id count
        expect(countValue).toEqual(1);                                // прописываем сам тест. ожидаем что эта переменная в самом начале работы равна нулю
    })

    test("counter should increment by 1 if the increment button is clicked", () => {
        const { getByTestId} = render(<Counter2 count={1} />);
        // const incrementBttn = getByRole("button", {className: "Increment"});
        const incrementBttn = document.getElementsByClassName('increase-button')[0];
        const countValue1 = Number(getByTestId("count").textContent);
        
        expect(countValue1).toEqual(1);
        fireEvent.click(incrementBttn); // симилуриуем нажим на кнопку
        const countValue2 = Number(getByTestId("count").textContent);
        // const count_value = Number(document.getElementsByClassName("count_value")[0].textContent);
        expect(countValue2).toEqual(2);
    })

    test("counter should increment by 1 if the increment button is clicked", () => {
        const { getByTestId} = render(<Counter2 count={1} />);
        // const incrementBttn = getByRole("button", {className: "Increment"});
        const decrementBttn = document.getElementsByClassName('decrease-button')[0];
        const countValue1 = Number(getByTestId("count").textContent);
        
        expect(countValue1).toEqual(1);
        fireEvent.click(decrementBttn); // симилуриуем нажим на кнопку
        const countValue2 = Number(getByTestId("count").textContent);
        // const count_value = Number(document.getElementsByClassName("count_value")[0].textContent);
        expect(countValue2).toEqual(0);
    })

})