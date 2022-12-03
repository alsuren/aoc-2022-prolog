from pyDatalog import pyDatalog

pyDatalog.create_terms("X,Y,Z, Elf, Layer, package, running_total")

"""
"""


@pyDatalog.program()
def _():

    # pydatalog doesn't like having a layer numbered 0 for some reason
    +package(elf1, 1, 0)
    +package(elf1, 2, 1000)
    +package(elf1, 3, 2000)
    +package(elf1, 4, 3000)

    +package(elf2, 1, 0)
    +package(elf2, 2, 4000)

    +package(elf3, 1, 0)
    +package(elf3, 2, 5000)
    +package(elf3, 3, 6000)

    +package(elf4, 1, 0)
    +package(elf4, 2, 7000)
    +package(elf4, 3, 8000)
    +package(elf4, 4, 9000)

    +package(elf5, 1, 0)
    +package(elf5, 2, 10000)
    # if there is a package for level 1 then there is an empty package at level 0
    # package(Elf, 0, 0) <= package(Elf, 1, _)
    print(package(Elf, Layer, Total))

    # FIXME: why can't I make this recursive?
    running_total(Elf, Layer, Total) <= package(Elf, Layer, Cost1) & (
        LayerBelow == Layer - 1
    ) & package(Elf, LayerBelow, Cost2) & (Total == Cost1 + Cost2)
    # running_total[Elf, Y] <= (package(Elf, Y, C) + running_total[Elf, Y - 1])
    print(running_total(Elf, Layer, Total))
    # running_total(Elf, 0, 0)

    # (longest_path[Elf, Layer] == max_(Path, order_by=Total)) <= (
    #     running_total(Elf, Layer, Path, Total)
    # )
    # print(longest_path[Elf, Layer])
    # print(running_total(Elf, Layer, Total))


#     (path_with_cost(X, Y, P, T)) <= (path_with_cost(X, Z, P2, T2)) & link(Z, Y, C) & (
#         X != Y
#     ) & (X._not_in(P2)) & (Y._not_in(P2)) & (P == P2 + [Z]) & (T == T2 + C)
#     (path_with_cost(X, Y, P, T)) <= link(X, Y, C) & (P == []) & (T == 0)


# @pyDatalog.program()
# def _():
#     +link(1, 2, 10)
#     +link(2, 3, 10)
#     +link(2, 4, 10)
#     +link(2, 5, 10)
#     +link(5, 6, 10)
#     +link(6, 7, 10)
#     +link(7, 2, 10)
#     +link(8, 9, 10)

#     link(X, Y, C) <= link(Y, X, C)  # optional : make each link bi-directional

#     print(link(1, Y, C))

#     print("can reach from 1")
#     can_reach(X, Y) <= can_reach(X, Z) & link(Z, Y, C) & (X != Y)
#     can_reach(X, Y) <= link(X, Y, C)
#     print(can_reach(1, Y))

#     print("can't reach from 1")
#     print(link(X, Y, C) & (~can_reach(1, X)) & (X != 1))

#     print("all path from/to 1")
#     all_path(X, Y, P) <= all_path(X, Z, P2) & link(Z, Y, C) & (X != Y) & (
#         X._not_in(P2)
#     ) & (Y._not_in(P2)) & (P == P2 + [Z])
#     all_path(X, Y, P) <= link(X, Y, C) & (P == [])

#     print(all_path(X, 1, P))

#     print("no path from 1")
#     print(link(X, Y, C) & (~all_path(1, X, P)) & (X != 1))

#     print("a path from / to 1")
#     (path[X, Y] == P) <= (
#         (path[X, Z] == P2)
#         & link(Z, Y, C)
#         # dropping next line is an unsafe optimisation. see negation below
#         # & (X!=Y) & (X._not_in(P2)) & (Y._not_in(P2))
#         & (P == P2 + [Z])
#     )
#     (path[X, Y] == P) <= link(X, Y, C) & (P == [])

#     print(path[1, Y] == P)

#     print("not one path from 1")
#     (safe_path[X, Y] == P) <= (
#         (safe_path[X, Z] == P2)
#         & link(Z, Y, C)
#         # next line needed to avoid infinite loop in negation
#         & (X != Y)
#         & (X._not_in(P2))
#         & (Y._not_in(P2))
#         & (P == P2 + [Z])
#     )
#     (safe_path[X, Y] == P) <= link(X, Y, C) & (P == [])
#     print(link(X, Y, C) & (X != 1) & (~(safe_path[X, 1] == P)))

#     print("path with cost from / to 1")
#     (path_with_cost(X, Y, P, T)) <= (path_with_cost(X, Z, P2, T2)) & link(Z, Y, C) & (
#         X != Y
#     ) & (X._not_in(P2)) & (Y._not_in(P2)) & (P == P2 + [Z]) & (T == T2 + C)
#     (path_with_cost(X, Y, P, T)) <= link(X, Y, C) & (P == []) & (T == 0)

#     print(path_with_cost(1, Y, P, T))
#     print(path_with_cost(Y, 1, P, T))

#     print("shortest path from / to 1")
#     (shortest_path[X, Y] == min_(P, order_by=T)) <= (path_with_cost(X, Y, P, T))

#     print(shortest_path[1, Y] == P)
#     print(shortest_path[X, 1] == P)
