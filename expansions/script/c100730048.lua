--高速决斗技能--抽卡预感：高星
Duel.LoadScript("speed_duel_common.lua")
function c100730048.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(76297408,c)
	if not c100730048.UsedLP then
		c100730048.UsedLP={}
		c100730048.UsedLP[0]=0
		c100730048.UsedLP[1]=0
	end
	aux.SpeedDuelCalculateDecreasedLP()
	aux.SpeedDuelReplaceDraw(c,c100730048.skill,c100730048.con,aux.Stringid(100730048,1))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730048.skill(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	if Duel.SelectYesNo(tp,aux.Stringid(100730048,0)) then
		Duel.Hint(HINT_CARD,1-tp,100730048)
		c100730048.UsedLP[tp]=c100730048.UsedLP[tp]+1000
		local g=Duel.GetMatchingGroup(Card.IsLevelAbove,tp,LOCATION_DECK,0,nil,5)
		if not g or g:GetCount()==0 then return end
		g=g:RandomSelect(tp,1)
		Duel.MoveSequence(g:GetFirst(),0)
		e:Reset()
	end
end

function c100730048.con(e,tp,eg,ep,ev,re,r,rp)
	tp = e:GetLabelObject():GetOwner()
	return Duel.GetTurnPlayer()==tp
		and Duel.GetMatchingGroupCount(Card.IsLevelAbove,tp,LOCATION_DECK,0,nil,5)>0
		and aux.DecreasedLP[tp]-c100730048.UsedLP[tp] >= 1000
end