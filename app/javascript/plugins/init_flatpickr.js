import flatpickr from 'flatpickr';

const currentDay = () => {
    return new Date().toJSON().slice(0, 10).replace(/-/g, '/');
}


const calendar = () => {
    const inputs = document.querySelectorAll(".calendar")
    console.log(currentDay())
    inputs.forEach((input) => {
        flatpickr(input, {
            minDate: currentDay()
        })
    })
}

export { calendar }