use chrono::Datelike;
use chrono::{Local, NaiveDate};
use clap::Parser;
use std::env;

#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
struct Opts {
    #[arg(value_parser = parse_birthdate, help = "Birthdate in YYYY-MM-DD format")]
    birthdate: NaiveDate,

    #[arg(help = "Username")]
    username: Option<String>,
}

fn parse_birthdate(s: &str) -> Result<NaiveDate, String> {
    NaiveDate::parse_from_str(s, "%Y-%m-%d")
        .map_err(|_| "Invalid date format. Please use YYYY-MM-DD.".to_string())
}

fn main() {
    let opts: Opts = Opts::parse();

    let name = opts.username.unwrap_or(env::var("USER").unwrap());
    let life_expectancy = 80;
    let birthdate_parsed = opts.birthdate;

    let current_date = Local::now().date_naive();
    let weeks_passed = (current_date - birthdate_parsed).num_days() / 7;
    let total_weeks = life_expectancy * 52;
    let weeks_remaining = total_weeks - weeks_passed;
    let birth_year = birthdate_parsed.year() as i64;
    let years_passed = current_date.year() as i64 - birth_year;
    let last_year = birth_year + life_expectancy - 1;

    println!("{}, only {} Sundays remain\n", name, weeks_remaining);

    for year_index in 0..life_expectancy {
        if year_index == 0 {
            println!("{}", birth_year);
        }

        if year_index < years_passed {
            print!("\x1b[41m  \x1b[0m ");
        } else {
            print!("\x1b[42m  \x1b[0m ");
        }

        if (year_index + 1) % 20 == 0 {
            let line_break = if year_index == life_expectancy - 1 {
                "\n"
            } else {
                "\n\n"
            };
            print!("{}", line_break);
        }
    }
    println!("{:55}{}", "", last_year);

    println!("\n\nHow are you going to spend these Sundays, {}?", name);
}
