--高速决斗技能-折断的闪刀
Duel.LoadScript("speed_duel_common.lua")
function c100730276.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730276.skill,c100730276.con,aux.Stringid(100730276,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730276.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c100730276.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730276.filter,tp,0,LOCATION_GRAVE,1,nil)
		and Duel.GetLP(tp)+2000<=Duel.GetLP(1-tp)
end
function c100730276.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730276)
	local g1=Duel.GetMatchingGroup(nil,tp,0,LOCATION_GRAVE,nil)
	local g2=Group.CreateGroup()
	local tc=g1:GetFirst()
	while tc do
		if tc:IsType(TYPE_SPELL+TYPE_TRAP) then
			g2:AddCard(Duel.CreateToken(1-tp,41587307))
		else
			g2:AddCard(Duel.CreateToken(1-tp,tc:GetOriginalCode()))
		end
		tc=g1:GetNext()
	end
	Duel.Exile(g1,REASON_RULE)
	Duel.SendtoGrave(g2,REASON_RULE)
	e:Reset()
end