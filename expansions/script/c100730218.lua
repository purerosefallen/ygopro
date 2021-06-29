--高速决斗技能--嘻嘻嘻嘻（虫鸣不止）
Duel.LoadScript("speed_duel_common.lua")
function c100730218.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(22991179,c)
	if not c100730218.UsedLP then
		c100730218.UsedLP={}
		c100730218.UsedLP[0]=0
		c100730218.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730218.skill,c100730218.con,aux.Stringid(100730218,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730218.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730218,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730218)
		c100730218.UsedLP[tp]=c100730218.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsRace,tp,LOCATION_DECK,0,nil,RACE_INSECT)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730218.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsRace,tp,LOCATION_DECK,0,nil,RACE_INSECT)>0
		and aux.DecreasedLP[tp]-c100730218.UsedLP[tp] >= 1000
end