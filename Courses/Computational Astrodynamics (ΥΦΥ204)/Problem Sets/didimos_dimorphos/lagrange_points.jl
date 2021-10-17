using Plots, LaTeXStrings

# System properties
m_didimos = 5.32 * ^(10, 11)
m_dimorphos = 4.94 * ^(10, 9)
mu = m_dimorphos / (m_didimos + m_dimorphos)
R_didimos = 325
R_dimorphos = 80
r = 1180
a = ^(mu/3, 1/3)

Lx = Vector{Float64}(undef, 5)
Ly = Vector{Float64}(undef, 5)

# Compute L1, L2 and L3

Lx[1] = 1 - mu - a + ^(a, 2)/3 + ^(a, 3)/9 + 23 * ^(a, 4)/81
Lx[2] = 1 - mu + a + ^(a, 2)/3 - ^(a, 3)/9 - 23 * ^(a, 4)/81  
Lx[3] = -1 - mu + 7*mu/(12*(1-mu)) - 7 * ^(mu/(1-mu), 2)/12 + 13223 * ^(mu/(1-mu), 3)/20736
Ly[1:3] .= 0

# Compute L4, L5

Lx[4] = 1/2 - mu
Ly[4] = ^(3, 1/2)/2
Lx[5] = 1/2 + mu
Ly[5] = - ^(3, 1/2)/2

# Print Lagrange points locations
for i = 1:length(Lx)
    println("L", string(i), ": x=", string(Lx[i]), ", y=", string(Ly[i]))
end

# Circle function to plot the asteroids
function circle(x_center, y_center, radius)
    theta = LinRange(0, 2*π, 500)
    x_center .+ radius*sin.(theta), y_center .+ radius*cos.(theta)
end

# Create plot
gr()
plot(Lx, Ly, seriestype = :scatter, label = "Lagrange points", series_annotations = text.([L"L_{1}", L"L_{2}", L"L_{3}", L"L_{4}", L"L_{5}"], :bottom))
plot!(circle(-mu, 0, R_didimos/r), seriestype = [:shape,], fillalpha =0.5, label="Didimos")
plot!(circle(1-mu, 0, R_dimorphos/r), seriestype = [:shape,], fillalpha =0.5, label="Dimorphos")
plot!(ylim=(-1,1), aspect_ratio=:equal, legend=:topleft, title="Lagrange points for Didimos-Dimorphos system")
plot!(xlabel = "x, [normalized units]", ylabel = "y, [normalized units]")
