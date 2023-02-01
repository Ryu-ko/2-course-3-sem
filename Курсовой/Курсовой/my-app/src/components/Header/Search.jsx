import React, { Component } from 'react'
import "../../styles/header.css"
import srch from '../../img/main/icon/лупа.svg'


export default class Search extends Component {
  render() {
   /* onChange = (e) => {
        this.setState(() => this.props.search(e.target.value));
    };
*/

    return (
      <div className="srch">
        <form>
            <input className="search-input" type="search" onChange={this.onChange}/>
            <button type="submit" src={srch}> </button>
        </form>

      </div>
    )
  }
}
