--高速决斗技能-其名为完全败北之鞭
Duel.LoadScript("speed_duel_common.lua")
function c100730158.initial_effect(c)
	aux.SpeedDuelReplaceDraw(c,c100730158.skill,c100730158.con,aux.Stringid(100730158,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730158.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp 
	and Duel.GetTurnCount()>=6
end
function c100730158.Is8800(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:GetDefense()>3500
end
function c100730158.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730158,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730158)
		local c=Duel.CreateToken(tp,55410871)
		Duel.SendtoDeck(c,tp,0,REASON_RULE)
		local g=Duel.GetMatchingGroup(c100730158.Is8800,1-tp,LOCATION_MZONE,0,nil)
		if g:GetCount()==0 then return end
			local c=Duel.CreateToken(tp,21082832)
			Duel.SendtoHand(c,nil,REASON_RULE)
			e:Reset()
		end
end