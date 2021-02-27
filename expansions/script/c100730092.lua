--高速决斗技能--生命总会找到出路
Duel.LoadScript("speed_duel_common.lua")
function c100730092.initial_effect(c)
	if not c100730092.UsedLP then
		c100730092.UsedLP={}
		c100730092.UsedLP[0]=0
		c100730092.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730092.skill,c100730092.con,aux.Stringid(100730092,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730092.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730092,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730092)
		c100730092.UsedLP[tp]=c100730092.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,RACE_DINOSAUR)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730092.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsType,tp,LOCATION_DECK,0,nil,RACE_DINOSAUR)>0
		and aux.DecreasedLP[tp]-c100730092.UsedLP[tp] >= 1000
end