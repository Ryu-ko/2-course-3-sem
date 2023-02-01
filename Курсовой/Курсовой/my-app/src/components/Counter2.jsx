import React from 'react'


const Counter2 = (props) => {

    const [count, setCount] = React.useState(1);

    const increase = (e) => {
        setCount(count + 1)
    }

    const decrease = (e) => {
        setCount(count - 1)
    }

    return (
        <div>
            <button onClick={increase} value={count} className="increase-button">INc</button>

                <p data-testid="count">{props.count}</p>

            <button onClick={decrease} value={count} className="decrease-button">Dec</button>
        </div>
    )
}

export default Counter2